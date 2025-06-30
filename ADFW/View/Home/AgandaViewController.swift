//
//  AgandaViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit


enum AgendaDisplayRow {
    case agendaHeader(AgendaRow)
    case session(Agenda_sessions, location: String, image: String?)
}

struct AgendaRow {
    let agendaTitle: String
    let location: String?
    let sessions: [Agenda_sessions]
    let image: String?
}

class AgandaViewController: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    weak var delegate: FilterSelectionDelegate?
    private var updateScheduled = false
    var updateWorkItem: DispatchWorkItem?
    private var searchDebounceWorkItem: DispatchWorkItem?
    
    @IBOutlet weak var searchTextField: UITextField!
    

    var selectedIndex = ""
    var viewModel = EventAgandaViewModel()
    var id:Int?
    var data = [EventAgandaData]()
    var filterSelectionData = [AgandaFilterData]()
    var arrDate = [EventAgandaData]()
    var filterData = [EventAgandaData]()
    var date:String?
    var selectedTags = Set<AgandaFilter>()
    var originalData: [EventAgandaData] = []
    var isDateSet:Bool = false

    var isSingleDataMode: Bool {
        return data.count == 1
    }

    @IBOutlet weak var noDataFoundImageView: UIImageView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource  = self
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.delegate = self
        registerCell()
        configureUI()
       // getEventData(date: self.date ?? "", id: self.id)
        getEventFilterData()
        getEventData(isSessionFilter: false, date: "", id: nil) { [weak self] in
            guard let self = self else { return }

            if let selectedDate = self.date {
                self.getEventData(isSessionFilter: true, date: selectedDate, id: id)
            }
        }
        
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    
    func registerCell() {
        collectionView.register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DateCollectionViewCell")
    
        tableView.register(UINib(nibName: "AgendaTableViewCell", bundle: nil), forCellReuseIdentifier: "AgendaTableViewCell")
        
        tableView.register(UINib(nibName: "MajorEventTableViewCell", bundle: nil), forCellReuseIdentifier: "MajorEventTableViewCell")
        
        tableView.register(UINib(nibName: "AgendaHeaderCell", bundle: nil), forCellReuseIdentifier: "AgendaHeaderCell")

        
        let nib = UINib(nibName: "AgendaHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "AgendaHeaderView")

    }
    
    func configureUI() {
        let fullText = "Event Agenda"
        let attributedString = NSMutableAttributedString(string: fullText)

        // Split text into words
        let words = fullText.components(separatedBy: " ")

        if words.count == 2,
           let firstRange = fullText.range(of: words[0]),
           let secondRange = fullText.range(of: words[1]) {

            let nsFirst = NSRange(firstRange, in: fullText)
            let nsSecond = NSRange(secondRange, in: fullText)

            // Style for "Event"
            attributedString.addAttributes([
                .font: FontManager.font(weight: .semiBold, size: 19),
                .foregroundColor: UIColor.black
            ], range: nsFirst)

            // Style for "Agenda"
            attributedString.addAttributes([
                .font: FontManager.font(weight: .bold, size: 19),
                .foregroundColor: UIColor.blueColor
            ], range: nsSecond)
        }

        pageTitle.attributedText = attributedString
        searchBarView.layer.borderColor = UIColor(hex: "#A3A6A7").cgColor
        searchBarView.layer.borderWidth = 1
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
        
    }
    
    
    func filterData(withTags tags: [AgandaFilter]) {
        self.selectedTags = Set(tags)
        
        if tags.isEmpty {
            data = originalData
        } else {
            data = originalData.compactMap { section in
                guard let agendas = section.agendas else { return nil }

                let filteredAgendas = agendas.filter { agenda in
                    guard let title = agenda.title else { return false }
                    return tags.contains(where: { tag in
                        title.localizedCaseInsensitiveContains(tag.title ?? "")
                    })
                }

                if !filteredAgendas.isEmpty {
                    var updatedSection = section
                    updatedSection.agendas = filteredAgendas
                    return updatedSection
                } else {
                    return nil
                }
            }
        }

        tableView.reloadData()
    }
    
    
//    func filterData(withSearchText searchText: String) {
//        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        if trimmedText.isEmpty {
//            data = originalData
//        } else {
//            data = originalData.compactMap { section -> EventAgandaData? in
//                guard let agendas = section.agendas else { return nil }
//
//                let filteredAgendas = agendas.filter { agenda in
//                    // Check agenda title
//                    let titleMatch = agenda.title?.localizedCaseInsensitiveContains(trimmedText) ?? false
//                    // Check agenda location
//                    let locationMatch = agenda.location?.name?.localizedCaseInsensitiveContains(trimmedText) ?? false
//
//                    // Check if any session title matches
//                    let sessionMatch = agenda.agenda_sessions?.contains(where: { session in
//                        let match = session.sessionType?.name?.localizedCaseInsensitiveContains(trimmedText) ?? false
//                        print("Checking sessionType: \(session.sessionType?.name ?? "nil"), match: \(match)")
//                        return match
//                    }) ?? false
//
//
//                    return titleMatch || locationMatch || sessionMatch
//                }
//
//                if !filteredAgendas.isEmpty {
//                    var updatedSection = section
//                    updatedSection.agendas = filteredAgendas
//                    return updatedSection
//                } else {
//                    return nil
//                }
//            }
//        }
//
//        tableView.reloadData()
//    }

    
    func filterData(withSearchText searchText: String) {
//        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        if trimmedText.isEmpty {
//            data = originalData
//        } else {
//            data = originalData.compactMap { section -> EventAgandaData? in
//                guard let agendas = section.agendas else { return nil }
//
//                let filteredAgendas = agendas.filter { agenda in
//                    // ✅ Only filter by sessionType name
//                    let sessionMatch = agenda.agenda_sessions?.contains(where: { session in
//                        let match = session.sessionType?.name?.localizedCaseInsensitiveContains(trimmedText) ?? false
//                        print("Checking sessionType: \(session.sessionType?.name ?? "nil"), match: \(match)")
//                        return match
//                    }) ?? false
//
//                    return sessionMatch
//                }
//
//                if !filteredAgendas.isEmpty {
//                    var updatedSection = section
//                    updatedSection.agendas = filteredAgendas
//                    return updatedSection
//                } else {
//                    return nil
//                }
//            }
//        }
        
        self.getEventData(isSessionFilter: true, date: self.date ?? "", search: searchText, isSessionSearch: true, id: nil)

        tableView.reloadData()
    }
    
    
    @IBAction func favoriteAction(_ sender: Any) {
        
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

extension AgandaViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDate.count + 1
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as! DateCollectionViewCell

           // Safety check: ensure there's data
           guard !arrDate.isEmpty else {
               return cell
           }

           if indexPath.row == 0 {
               // "Full Week" option
               let isSelected = selectedIndex == "Full Week"
               cell.configure(with: "Full Week", isSelected: isSelected)
           } else {
               // Adjust index to match arrDate
               let dataIndex = indexPath.row - 1
               if dataIndex < arrDate.count {
                   let dateItem = arrDate[dataIndex]
                   let formattedDate = Helper.formatToDayMonth(from: dateItem.date ?? "") ?? ""
                   let isSelected = dateItem.date == selectedIndex
                   cell.configure(with: formattedDate, isSelected: isSelected)
               }
           }

           return cell

           
         
       }

       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
           if indexPath.item == 0 {
               selectedIndex = "Full Week"
               self.date = ""
               getEventData(isSessionFilter: false, date: "", id: nil)
           } else {
               self.date = arrDate[indexPath.row - 1].date ?? ""
               selectedIndex = arrDate[indexPath.row - 1].date ?? ""
               getEventData(isSessionFilter: true, date: arrDate[indexPath.row - 1].date ?? "", id: nil)
           }
           collectionView.reloadData()
           tableView.setContentOffset(.zero, animated: true)
       }
    
}


extension AgandaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8) // Adjust spacing as needed
       }
}



extension AgandaViewController: UITableViewDelegate, UITableViewDataSource {

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      
//        return data[section].agendas?.first?.agenda_sessions?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = data[indexPath.section].agendas?.first?.agenda_sessions?[indexPath.row]
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
//        
//      //  cell.delegate = self
//          cell.onPlayVideo = { [weak self] in
//               guard let self = self else { return }
//
//            let youtubeURL = item?.video ?? "" // or your actual URL string
//
//            if let videoID = youtubeURL.extractYouTubeID() {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                if let videoVC = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController {
//                    videoVC.videoID = videoID
//                    videoVC.modalPresentationStyle = .fullScreen
//                    self.present(videoVC, animated: true)
//                }
//            } else {
//                print("❌ Invalid YouTube URL")
//            } }
//
//        
//        
//        if let sess = item {
//            cell.configure(with: sess, location: data[indexPath.section].agendas?.first?.location?.name ?? "")
//        }
//       
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AgendaHeaderView") as? AgendaHeaderView else {
//            return nil
//        }
//        
//        let image = data[section].agendas?.first?.image
//        let sectionData = data[section]
//        header.delegate = self
//        header.configure(dateText: Helper.formatToDayFullMonth(from: sectionData.date ?? "") ?? "", yearText: Helper.extractYear(from: sectionData.date ?? "") ?? "" , bannerImage: image, hide: true)
//        
//
//        return header
//    }
//
//    
    
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





 //MARK: API Calling
extension AgandaViewController {
    
    func getEventData(isSessionFilter: Bool, date: String, search: String? = nil, isSessionSearch: Bool = false, id: Int?,completion: (() -> Void)? = nil) {
        viewModel.agandaData(isSessionFilter: isSessionFilter, date: date, search: search, isSessionSearch: isSessionSearch, page: 1, id: id, in: self.view) { result in
            switch result {
            case .success(let response):
                print("data:", response)
    
               
                if self.isDateSet{
                   
                } else {
                    self.isDateSet = true
                    self.arrDate = response
                }
                self.data = response
                self.originalData = response
                self.filterData(withTags: Array(self.selectedTags))
                self.collectionView.reloadData()
                completion?()
        
            case .failure(let error):
                // self.showNoDataView(true)
                print(error.localizedDescription)
                MessageHelper.showToast(message: error.localizedDescription, in: self.view)
            }
        }
    }

    
    func getEventFilterData() {
        viewModel.agandaFilterData(page: 1, id: self.id ?? 0, in: self.view) { result in
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


extension AgandaViewController: HomeSessionTableViewCellDelegate {
  
    func homeSessionCellDidUpdateHeight() {
        updateWorkItem?.cancel()
        updateWorkItem = DispatchWorkItem {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: updateWorkItem!)
    }
}

extension AgandaViewController: FilterSelectionDelegate {
    func didUpdateSelectedTags(_ tags: [AgandaFilter]) {
        filterData(withTags: tags)
    }
}






//extension AgandaViewController {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return data.count
//    }
//
//    func buildAgendaRows(for section: Int) -> [AgendaRow] {
//        guard let agendas = data[section].agendas else { return [] }
//
//        return agendas.map { agenda in
//            AgendaRow(
//                agendaTitle: agenda.title ?? "",
//                location: agenda.location?.name,
//                sessions: agenda.agenda_sessions ?? [],
//                image: agenda.image
//            )
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let agendaRows = buildAgendaRows(for: section)
//        return agendaRows.reduce(0) { $0 + $1.sessions.count }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let agendaRows = buildAgendaRows(for: indexPath.section)
//
//        var sessionIndex = indexPath.row
//        for agendaRow in agendaRows {
//            if sessionIndex < agendaRow.sessions.count {
//                let session = agendaRow.sessions[sessionIndex]
//
//                let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
//                cell.configure(with: session, location: agendaRow.location ?? "")
//
//                cell.onPlayVideo = { [weak self] in
//                    guard let self = self, let url = session.video, let videoID = url.extractYouTubeID() else {
//                        print("❌ Invalid YouTube URL")
//                        return
//                    }
//
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    if let videoVC = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController {
//                        videoVC.videoID = videoID
//                        videoVC.modalPresentationStyle = .fullScreen
//                        self.present(videoVC, animated: true)
//                    }
//                }
//
//                return cell
//            } else {
//                sessionIndex -= agendaRow.sessions.count
//            }
//        }
//
//        fatalError("Invalid session index")
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AgendaHeaderView") as? AgendaHeaderView else {
//            return nil
//        }
//
//        let date = data[section].date ?? ""
//        let image = data[section].agendas?.first?.image // Safely get first image if exists
//
//        header.configure(
//            dateText: Helper.formatToDayFullMonth(from: date) ?? "",
//            yearText: Helper.extractYear(from: date) ?? "",
//            bannerImage: image,
//            hide: true // Hide image view only if image is nil
//        )
//
//        return header
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let agendaRows = buildAgendaRows(for: indexPath.section)
//
//        var sessionIndex = indexPath.row
//        for agendaRow in agendaRows {
//            if sessionIndex < agendaRow.sessions.count {
//                let session = agendaRow.sessions[sessionIndex]
//                let date = data[indexPath.section].date ?? ""
//
//                let vc = storyboard?.instantiateViewController(withIdentifier: "SessionViewController") as! SessionViewController
//                vc.session = Session(
//                    date: Helper.formatToDayFullMonth(from: date) ?? "",
//                    title: session.title ?? "",
//                    description: session.description ?? "",
//                    time: "\(session.fromTime ?? "") - \(session.toTime ?? "")",
//                    location: agendaRow.location ?? "",
//                    bannerImage: agendaRow.image ?? "",
//                    speakers: session.speakers ?? [],
//                    moderators: session.moderator
//                )
//
//                navigationController?.pushViewController(vc, animated: true)
//                return
//            } else {
//                sessionIndex -= agendaRow.sessions.count
//            }
//        }
//    }
//}


extension AgandaViewController {

    var filteredData: [EventAgandaData] {
        return data.filter { section in
            section.agendas?.contains { ($0.agenda_sessions?.isEmpty == false) } ?? false
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildDisplayRows(for: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rows = buildDisplayRows(for: indexPath.section)
        let row = rows[indexPath.row]

        switch row {
        case .agendaHeader(let agendaRow):
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaHeaderCell", for: indexPath) as! AgendaHeaderCell
            cell.delegate = self
            cell.configure(title: agendaRow.agendaTitle, imageURL: agendaRow.image)
            return cell

        case .session(let session, let location, let image):
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
            cell.configure(with: session, location: location)

            // Play video button callback
            cell.onPlayVideo = { [weak self] in
                guard let self = self, let url = session.video, let videoID = url.extractYouTubeID() else { return }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let videoVC = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController {
                    videoVC.videoID = videoID
                    videoVC.modalPresentationStyle = .fullScreen
                    self.present(videoVC, animated: true)
                }
            }

            // View detail button callback
            cell.viewDetail = { [weak self] in
                guard let self = self else { return }
                let date = filteredData[indexPath.section].date ?? ""

                let vc = storyboard?.instantiateViewController(withIdentifier: "SessionViewController") as! SessionViewController
                vc.session = Session(
                    date: Helper.formatToDayFullMonth(from: date) ?? "", year: Helper.extractYear(from: date) ?? "",
                    title: session.title ?? "",
                    description: session.description ?? "",
                    time: "\(session.fromTime ?? "") - \(session.toTime ?? "")",
                    location: location,
                    bannerImage: image ?? "",
                    speakers: session.speakers ?? [],
                    moderators: session.moderator
                )
                self.navigationController?.pushViewController(vc, animated: true)
            }

            return cell
        }
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AgendaHeaderView") as? AgendaHeaderView else {
            return nil
        }

        let date = filteredData[section].date ?? ""
        header.configure(
            dateText: Helper.formatToDayFullMonth(from: date) ?? "",
            yearText: Helper.extractYear(from: date) ?? "",
            bannerImage: "", // update if needed
            hide: false
        )
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    // MARK: - Helper to flatten rows
    func buildDisplayRows(for section: Int) -> [AgendaDisplayRow] {
        guard let agendas = filteredData[section].agendas else { return [] }

        var rows: [AgendaDisplayRow] = []

        for agenda in agendas {
            guard let sessions = agenda.agenda_sessions, !sessions.isEmpty else {
                continue
            }

            let agendaRow = AgendaRow(
                agendaTitle: agenda.title ?? "",
                location: agenda.location?.name,
                sessions: sessions,
                image: agenda.image
            )
            rows.append(.agendaHeader(agendaRow))

            for session in sessions {
                rows.append(.session(session, location: agenda.location?.name ?? "", image: agenda.image))
            }
        }

        return rows
    }
}


extension AgandaViewController: UITextFieldDelegate {
    @objc func searchTextChanged(_ textField: UITextField) {
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


