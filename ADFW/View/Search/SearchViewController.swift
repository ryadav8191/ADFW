//
//  SearchViewController.swift
//  ADFW
//
//  Created by MultiTV on 10/07/25.
//

import UIKit

struct SectionHeaderData {
    let title: String
    let rows: [Any] // You can make this more specific with enums
}


class SearchViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var beginSearchView: UIView!
    @IBOutlet weak var searchBeginLabel: UILabel!
    @IBOutlet weak var ExporeLabel: UILabel!
    
    private let noDataView = NoDataView()
    let viewModel = SearchViewModel()
    var data: GlobalSearchData?
    private var searchDebounceWorkItem: DispatchWorkItem?
    var sections: [SectionHeaderData] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureUI()
      //  self.showNoDataView(true)
    }
    
    func configureUI() {
        searchView.layer.cornerRadius = 3
        backView.layer.cornerRadius = 3
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "MajorEventTableViewCell", bundle: nil), forCellReuseIdentifier: "MajorEventTableViewCell")
        tableView.register(UINib(nibName: "AgendaTableViewCell", bundle: nil), forCellReuseIdentifier: "AgendaTableViewCell")
        tableView.register(UINib(nibName: "GobalSpeakerTableViewCell", bundle: nil), forCellReuseIdentifier: "GobalSpeakerTableViewCell")
        
        
        let nib = UINib(nibName: "AgendaHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "AgendaHeaderView")
        
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        view.addSubview(noDataView)
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noDataView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDataView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noDataView.widthAnchor.constraint(equalTo: view.widthAnchor),
            noDataView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        noDataView.isHidden = true
        
        searchBeginLabel.font = FontManager.font(weight: .bold, size: 19)
        ExporeLabel.font = FontManager.font(weight: .regular, size: 14)
    }
    
    private func showNoDataView(_ show: Bool) {
        DispatchQueue.main.async {
            self.noDataView.isHidden = !show
        }
    }
    
    func buildSections() {
        sections = []

        if let agendas = data?.agendas?.data, !agendas.isEmpty {
            sections.append(SectionHeaderData(title: "Agendas", rows: agendas))
        }

        if let sessions = data?.sessions?.data, !sessions.isEmpty {
            sections.append(SectionHeaderData(title: "Sessions", rows: sessions))
        }

        if let speakers = data?.speakers?.data, !speakers.isEmpty {
            sections.append(SectionHeaderData(title: "Speakers", rows: speakers))
        }

        tableView.reloadData()
    }
   
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension SearchViewController:  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = sections[section]
        
        if sectionData.title == "Speakers" {
            return 1
        }
        
        return sectionData.rows.count
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = GlobalSearchHeaderView.instantiate()
        headerView.titleLabel.text = sections[section].title
        return headerView
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionData = sections[indexPath.section]
        
        switch sectionData.title {
        case "Agendas":
            
            let aganda = data?.agendas?.data?[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "MajorEventTableViewCell", for: indexPath) as! MajorEventTableViewCell
            cell.configure(with: aganda)
            cell.delegate = self
            
            cell.viewAganda = {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AgandaViewController") as? AgandaViewController {
                    vc.id = aganda?.id
                    vc.date = aganda?.date
                    vc.selectedIndex = Helper.extractDate(from: aganda?.date ?? "") ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            cell.viewWebSite = {
                if let url = URL(string: aganda?.websiteLink ?? "") {
                    UIApplication.shared.open(url)
                }
            }
            
            cell.viewDetail = {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventOveviewViewController") as? EventOveviewViewController {
                    vc.selectedIndex = aganda?.date ?? ""
                    vc.data = aganda
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            return cell
            
        case "Sessions":
            let eventAganda  =  data?.sessions?.data?[indexPath.row]
            let session = data?.sessions?.data?[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
            if let sess = session {
                cell.configure(with: sess , location: sess.location ?? "")
            }
            
            
            cell.onPlayVideo = { [weak self] in
                guard let self = self, let url = session?.video, let videoID = url.extractYouTubeID() else { return }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let videoVC = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController {
                    videoVC.videoID = videoID
                    videoVC.modalPresentationStyle = .fullScreen
                    self.present(videoVC, animated: true)
                }
            }
            
            cell.viewDetail = { [weak self] in
                guard let self = self else { return }
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SessionViewController") as! SessionViewController
                vc.session = Session(
                    id: eventAganda?.id ?? 0,
                    agandaId: session?.id ?? 0,
                    date: "",
                    year: Helper.extractYear(from: "") ?? "",
                    title: session?.title ?? "",
                    description: session?.description ?? "",
                    time: "\(session?.fromTime ?? "") - \(session?.toTime ?? "")",
                    location: "",
                    bannerImage:"",
                    speakers: (session?.speakers ?? []).map { Speaker(from: $0) },
                    moderators: session?.moderator != nil ? Speaker(from: session?.moderator!) : nil
                )
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
            
        case "Speakers":
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "GobalSpeakerTableViewCell", for: indexPath) as! GobalSpeakerTableViewCell
            cell.filteredItems = data?.speakers?.data
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionTitle = sections[indexPath.section].title
        
        switch sectionTitle {
        case "Agendas", "Sessions":
            return UITableView.automaticDimension
            
        case "Speakers":
            
            let speakerCount = data?.speakers?.data?.count ?? 0
            if speakerCount == 0 { return 0 }
            
            let itemsPerRow = 2
            let speakerCellHeight: CGFloat = 250  // or whatever your actual cell height is
            let rowSpacing: CGFloat = 10          // if you use inter-row spacing in your UICollectionView
            let verticalPadding: CGFloat = 20     // e.g., top + bottom inside your container
            
            let rows = Int(ceil(Double(speakerCount) / Double(itemsPerRow)))
            let totalHeight = (CGFloat(rows) * speakerCellHeight) + (CGFloat(rows - 1) * rowSpacing) + verticalPadding
            
            return totalHeight
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
}

extension SearchViewController {
    func getGobalData(search: String) {
        beginSearchView.isHidden = true
        
        guard !search.isEmpty else {
                    searchDebounceWorkItem?.cancel()
                    data = nil
                    buildSections()
                    showNoDataView(false)
                    beginSearchView.isHidden = false
                    tableView.reloadData()
                    return
                }
        
//        if search !=  "" {
            viewModel.fetchGobalSearchData(in: self.view, search: search, completion: { results in
                self.beginSearchView.isHidden = true
                switch results {
                case .success(let response):
                    
                    self.data = response
                    self.buildSections()
                    let isEmpty = (response.sessions?.data?.isEmpty ?? true) &&
                    (response.speakers?.data?.isEmpty ?? true) &&
                    (response.agendas?.data?.isEmpty ?? true)
                    self.showNoDataView(isEmpty)
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    self.showNoDataView(true)
                    print(error.localizedDescription)
                    MessageHelper.showBanner(message: error.localizedDescription, status: .error)
                }
            })
//        } else {
//            searchDebounceWorkItem?.cancel()
//            self.data = nil
//            self.buildSections()
//            self.showNoDataView(false)
//            beginSearchView.isHidden = false
//            self.tableView.reloadData()
//        }
        
        
    }
}



extension SearchViewController: HomeSessionTableViewCellDelegate {
    func homeSessionCellDidUpdateHeight() {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}


extension SearchViewController: UITextFieldDelegate {
    @objc func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text ?? ""

        // Cancel previous task
        searchDebounceWorkItem?.cancel()

        // Create new task
        let workItem = DispatchWorkItem { [weak self] in
            self?.getGobalData(search: searchText)
        }

        // Save reference to cancel if needed
        searchDebounceWorkItem = workItem

        // Execute after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: workItem)
    }
}

