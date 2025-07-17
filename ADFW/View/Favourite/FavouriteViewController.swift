//
//  FavouriteViewController.swift
//  ADFW
//
//  Created by MultiTV on 03/07/25.
//

import UIKit


enum FavouriteAgendaDisplayRow {
    case agendaHeader(FavouriteAgendaRow)
    case session(FavouriteSessions, location: String, image: String?, agandaId: Int )
}

struct FavouriteAgendaRow {
    let agendaTitle: String
    let location: String?
    let sessions: [FavouriteSessions]
    let image: String?
    let date: String
    let agandaId: Int
}

class FavouriteViewController: UIViewController {
    
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!

    let favViewModel = FavouriteViewModel()
    var isShowingFavourites = false
    var favouriteDisplayRows: [[AgendaDisplayRow]] = []
    var viewModel = EventAgandaViewModel()
    var selectedTags = Set<AgandaFilterData>()
    weak var delegate: FilterSelectionDelegate?
    private var updateScheduled = false
    var updateWorkItem: DispatchWorkItem?
    private var searchDebounceWorkItem: DispatchWorkItem?
    var originalData: [FavouriteData] = []
    var data = [FavouriteData]()
    var filterSelectionData = [AgandaFilterData]()
    private let noDataView = NoDataView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.delegate = self
        registerCell()
        configureUI()
        getEventFilterData()
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        view.addSubview(noDataView)
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noDataView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDataView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noDataView.widthAnchor.constraint(equalTo: view.widthAnchor),
            noDataView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        noDataView.isHidden = false
      
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        searchTextField.text = nil
        searchTextField.endEditing(false)
        getFav()
    }
    func registerCell() {
        tableView.register(UINib(nibName: "AgendaTableViewCell", bundle: nil), forCellReuseIdentifier: "AgendaTableViewCell")
        
        tableView.register(UINib(nibName: "MajorEventTableViewCell", bundle: nil), forCellReuseIdentifier: "MajorEventTableViewCell")
        
        tableView.register(UINib(nibName: "AgendaHeaderCell", bundle: nil), forCellReuseIdentifier: "AgendaHeaderCell")

        
        let nib = UINib(nibName: "AgendaHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "AgendaHeaderView")

    }
    
    func filterData(withTags tags: [AgandaFilterData]) {
        self.selectedTags = Set(tags)
        getFav(agandaId: tags.first?.id)
    }
    
    func configureUI() {
        let fullText = "Favourites"
        pageTitle.text = fullText
        pageTitle.font = FontManager.font(weight: .semiBold, size: 19)
        searchBarView.layer.borderColor = UIColor(hex: "#A3A6A7").cgColor
        searchBarView.layer.borderWidth = 1
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
        
    }
    
    private func showNoDataView(_ show: Bool) {
        DispatchQueue.main.async {
            self.noDataView.isHidden = !show
        }
    }
    
    
    func filterData(withSearchText searchText: String) {
        getFav(search: searchText)
        
    }
    
    
    @IBAction func filterAction(_ sender: Any) {
        let overlay = FilterOverlayView(frame: view.bounds)
           overlay.alpha = 0
        overlay.delegate = self
        overlay.selectedTags = self.selectedTags
        overlay.tags = self.filterSelectionData
           view.addSubview(overlay)
           UIView.animate(withDuration: 0.3) {
               overlay.alpha = 1
           }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
}


extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100 // Estimate close to real height
    }



    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
}


extension FavouriteViewController: HomeSessionTableViewCellDelegate {
  
    func homeSessionCellDidUpdateHeight() {
        updateWorkItem?.cancel()
        updateWorkItem = DispatchWorkItem {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: updateWorkItem!)
    }
}

extension FavouriteViewController {
    
    var filteredData: [FavouriteData] {
        return data.filter { section in
            section.agendas?.contains { ($0.sessions?.isEmpty == false) } ?? false
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return isShowingFavourites ? favouriteDisplayRows.count : filteredData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShowingFavourites ? favouriteDisplayRows[section].count : buildDisplayRows(for: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rows =  buildDisplayRows(for: indexPath.section)
           let row = rows[indexPath.row]

        switch row {
        case .agendaHeader(let agendaRow):
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaHeaderCell", for: indexPath) as! AgendaHeaderCell
            cell.delegate = self
            cell.configure(title: agendaRow.agendaTitle, imageURL: agendaRow.image)
            return cell

        case .session(let session, let location, let image, let agandaId):
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
            cell.configure(with: session, location: location)

            // Play video button callback
            cell.onPlayVideo = { [weak self] in
                guard let self = self, let url = session.session_video, let videoID = url.extractYouTubeID() else { return }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let videoVC = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController {
                    videoVC.videoID = videoID
                    videoVC.modalPresentationStyle = .fullScreen
                    self.present(videoVC, animated: true)
                }
            }

            cell.viewDetail = { [weak self] in
                guard let self = self else { return }

                var date = ""
                if self.isShowingFavourites {
                    let rows = self.favouriteDisplayRows[indexPath.section]
                    if let headerRow = rows.first(where: {
                        if case .agendaHeader = $0 { return true }
                        return false
                    }) {
                        if case let .agendaHeader(agendaRow) = headerRow {
                            date = agendaRow.date
                        }
                    }
                } else {
                    date = self.filteredData[indexPath.section].date ?? ""
                }

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SessionViewController") as! SessionViewController
                vc.session = Session(
                    id: session.session_id ?? 0,
                    agandaId: agandaId,
                    date: date,
                    year: Helper.extractYear(from: date) ?? "",
                    title: session.session_title ?? "",
                    description:"",
                    time: "\(session.session_from_time ?? "") - \(session.session_to_time ?? "")",
                    location: location,
                    bannerImage: image ?? "",
                    speakers: (session.speakers ?? []).map { Speaker(from: $0) },
                    moderators: session.moderators?.first != nil ? Speaker(from: session.moderators?.first!) : nil
                )
                self.navigationController?.pushViewController(vc, animated: true)
            }

            return cell
        }
    }


//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AgendaHeaderView") as? AgendaHeaderView else {
//            return nil
//        }
//
//        let date = filteredData[section].date ?? ""
//        header.configure(
//            dateText: Helper.formatToDayFullMonth(from: date) ?? "",
//            yearText: Helper.extractYear(from: date) ?? "",
//            bannerImage: "", // update if needed
//            hide: false
//        )
//        return header
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AgendaHeaderView") as? AgendaHeaderView else {
            return nil
        }

        if isShowingFavourites {
            // Safely get the agendaHeader row
            let rows = favouriteDisplayRows[section]
            if let headerRow = rows.first(where: {
                if case .agendaHeader = $0 { return true }
                return false
            }) {
                switch headerRow {
                case .agendaHeader(let agendaRow):
                    header.configure(
                        dateText: Helper.formatToDayFullMonth(from: agendaRow.date) ?? "",
                        yearText: Helper.extractYear(from: agendaRow.date) ?? "",
                        bannerImage: agendaRow.image ?? "",
                        hide: false
                    )
                default:
                    break
                }
            }
        } else {
            // Use filteredData
            let date = filteredData[section].date ?? ""
            header.configure(
                dateText: Helper.formatToDayFullMonth(from: date) ?? "",
                yearText: Helper.extractYear(from: date) ?? "",
                bannerImage: "", // Provide image if needed
                hide: false
            )
        }

        return header
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    // MARK: - Helper to flatten rows
    func buildDisplayRows(for section: Int) -> [FavouriteAgendaDisplayRow] {
        guard let agendas = filteredData[section].agendas else { return [] }

        var rows: [FavouriteAgendaDisplayRow] = []

        for agenda in agendas {
            guard let sessions = agenda.sessions, !sessions.isEmpty else {
                continue
            }

            let agendaRow = FavouriteAgendaRow(
                agendaTitle: agenda.agenda_title ?? "",
                location: agenda.location,
                 sessions: sessions,
                image: agenda.agenda_mobile_banner,
                 date: "",
                agandaId: agenda.agenda_id ?? 0
            )
            rows.append(.agendaHeader(agendaRow))

            for session in sessions {
                rows.append(.session(session, location: agenda.location ?? "", image: agenda.agenda_mobile_banner, agandaId: agenda.agenda_id ?? 0))
            }
        }
 
        return rows
    }
}



extension FavouriteViewController: FilterSelectionDelegate {
    func didUpdateSelectedTags(_ tags: [AgandaFilterData]) {
       
            filterData(withTags: tags)
               
    }
}


extension FavouriteViewController {
    
    func getFav(search: String? = nil,agandaId: Int? = nil) {
        favViewModel.fetchFavourites(ticketId: LocalDataManager.getUserId(),search: search,agendaId: agandaId, in: self.view) { result in
            switch result {
            case .success(let favourites):
               
                if favourites.count == 0 {
                    self.showNoDataView(true)
                } else {
                    self.showNoDataView(false)
                }
                self.data = favourites
                self.originalData = favourites
                self.tableView.reloadData()
            case .failure(let error):
                self.showNoDataView(true)
                print("Error fetching favourites: \(error.localizedDescription)")
            }
        }

    }
    
    func getEventFilterData() {
        viewModel.agandaFilterData(page: 1, id: 0, in: self.view) { result in
            switch result {
            case .success(let response):
                print("data:", response)
                self.filterSelectionData = response
             
               
            case .failure(let error):
                // self.showNoDataView(true)
                print(error.localizedDescription)
                MessageHelper.showToast(message: error.localizedDescription, in: self.view)
            }
        }
    }

}


extension FavouriteViewController: UITextFieldDelegate {
    
    @objc func searchTextChanged(_ textField: UITextField) {
        selectedTags = []
        let searchText = textField.text ?? ""

        // Cancel previous task
        searchDebounceWorkItem?.cancel()

        // Create new task
        let workItem = DispatchWorkItem { [weak self] in
            self?.filterData(withSearchText: searchText)
        }

        // Save reference to cancel if needed
        searchDebounceWorkItem = workItem

        // Execute after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
}
