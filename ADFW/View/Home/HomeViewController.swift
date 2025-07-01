//
//  HomeViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    //MARK: OutLets
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var notificationBell: UIButton!
    
    
    //MARK: ViewModel
    var viewModel = SpeakerViewModel()
    var homeViewModel = HomeViewModel()
    var venueViewModel = VenueViewModel()
    var featuredEventViewModel = FeaturedEventViewModel()
    var partnerViewModel = PartnerViewModel()
    
    //MARK: Propertise
    var arrayOfSpeaker = [SpeakerData]()
    var arrayOfSession = [UpcomingSessionsData]()
    var sideMenu: SideMenuNavigationController?
    private var pendingHeightUpdate: DispatchWorkItem?
    var locations: [Locations] = []
    var featuredData : [FeaturedEventData]?
    var partnerData : [Partner]?
    var homeData: [HomeData]?
    var aboutAdgm : [About_adgm]?
    var sidebarMenu : SidebarMenu?
    var section : [Sections]?
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let menuVC = storyboard?.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
        menuVC.delegate = self
        menuVC.sidebarMenu = self.sidebarMenu
        sideMenu = SideMenuNavigationController(rootViewController: menuVC)
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        sideMenu?.presentationStyle = .menuSlideIn
        sideMenu?.presentationStyle.backgroundColor = .black
        sideMenu?.presentationStyle.presentingEndAlpha = 0.5
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        registerCell()
        tableview.showsVerticalScrollIndicator = false
        getSpeakerData(search: "")
        getUpcommigSession()
        fetchVenueData()
        fetchFeaturedEvent()
        getPartnerData(page: 1)
        getHomeBanner()
    }
    
  
    
    func registerCell() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "BannerTableViewCell", bundle: nil), forCellReuseIdentifier: "BannerTableViewCell")  //
        tableview.register(UINib(nibName: "HomeSessionTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeSessionTableViewCell")  //AboutAGDMTableViewCell
        
        tableview.register(UINib(nibName: "AboutAGDMTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutAGDMTableViewCell") //ExploreTableViewCell
        
        tableview.register(UINib(nibName: "ExploreTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreTableViewCell")
        tableview.register(UINib(nibName: "EntertainmentTableViewCell", bundle: nil), forCellReuseIdentifier: "EntertainmentTableViewCell") ///ParterTableViewCell
        ///
        tableview.register(UINib(nibName: "ParterTableViewCell", bundle: nil), forCellReuseIdentifier: "ParterTableViewCell")   ///
        
        tableview.register(UINib(nibName: "HomeSpeakerTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeSpeakerTableViewCell")  //
        
        tableview.register(UINib(nibName: "ADFWMapTableViewCell", bundle: nil), forCellReuseIdentifier: "ADFWMapTableViewCell")
    }
    
    func updateSideMenu() {
       
    }
    
    func getSection(by id: String) -> Sections? {
        return section?.first(where: { $0.id == id })
    }

    
    
    @IBAction func sideMenu(_ sender: Any) {
        guard let sidebarData = sidebarMenu else {
               // Optional: show alert or toast that data is still loading
               print("Side menu data is not yet loaded.")
               return
           }

           if let menu = SideMenuManager.default.leftMenuNavigationController,
              let menuVC = menu.viewControllers.first as? MenuViewController {
               // Pass the updated data and reload
               menuVC.sidebarMenu = sidebarData
               _ = menuVC.view // Ensure view is loaded
               menuVC.tableView.reloadData()

               present(menu, animated: true, completion: nil)
           }
    }
    
    @IBAction func notificationAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return (homeData?.first?.attributes?.mobile_banner?.isEmpty == false) ? 1 : 0
        case 1: return arrayOfSession.isEmpty ? 0 : 1
        case 2: return featuredData?.isEmpty == false ? 1 : 0
        case 3: return arrayOfSpeaker.isEmpty ? 0 : 1
        case 4: return locations.isEmpty ? 0 : 1
        case 5: return partnerViewModel.partnerSections.isEmpty ? 0 : 1
        case 6: return (getSection(by: "exploreAbuDhabi")?.card != nil) ? 1 : 0
        case 7: return (getSection(by: "entertainmentADFW")?.card != nil) ? 1 : 0
        case 8: return (getSection(by: "aboutADGM")?.card != nil) ? 1 : 0
        default: return 0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell") as! BannerTableViewCell
            cell.banner = self.homeData?.first?.attributes?.mobile_banner
            //  cell.delegate = self
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSessionTableViewCell") as! HomeSessionTableViewCell
            
            cell.configure(with: self.arrayOfSession, type: .session)
            
            cell.onClickViewAll = {
//                let story = UIStoryboard(name: "Main", bundle: nil)
//                let vc  = story.instantiateViewController(identifier: "MajorEventViewController") as! MajorEventViewController
//                self.navigationController?.pushViewController(vc, animated: true)
                
                self.tabBarController?.selectedIndex = 1
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSessionTableViewCell") as! HomeSessionTableViewCell  //AboutAGDMTableViewCell
            cell.delegate = self
            cell.onClickViewAll = {
                self.tabBarController?.selectedIndex = 1
            }
            cell.configureFeatureEvent(data: self.featuredData ?? [])
            cell.configure(with: [], type: .event)
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ADFWMapTableViewCell") as! ADFWMapTableViewCell
            cell.locations = self.locations
            cell.configureMap()
            return cell
            
            
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSpeakerTableViewCell") as! HomeSpeakerTableViewCell
            cell.arrayOfSpeaker = self.arrayOfSpeaker
            
            
            cell.onClickViewAll = {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc  = story.instantiateViewController(identifier: "SpeakerViewController") as! SpeakerViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.delegate = self
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParterTableViewCell") as! ParterTableViewCell  //AboutAGDMTableViewCell //EntertainmentTableViewCell
            cell.partnerData = partnerViewModel.partnerSections
            
            cell.onClickViewAll = {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc  = story.instantiateViewController(identifier: "OurPartnerViewController") as! OurPartnerViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EntertainmentTableViewCell") as! EntertainmentTableViewCell
            
            if let section = getSection(by: "entertainmentADFW"),
                  let card = section.card {
                //cell.entertainbodyLabel.text = card.overlayText
                let urlString = card.image?.url ?? ""
                cell.bgImageView.setImage(with: urlString, placeholder: UIImage.entertainment)
                let labelText = "\(section.title?.label ?? "") \(section.title?.highlight ?? "")"
                cell.enterainmentLabel.setStyledTextWithLastWordColor(fullText: labelText, lastWordColor: .blueColor)
                cell.entertainbodyLabel.setStyledTextWithLastWordColor(fullText:  card.overlayText ?? "", lastWordColor: .blueColor,fontSize: 24)
                cell.entertainbodyLabel.textColor = .white
               }
            cell.onClickViewAll = {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc  = story.instantiateViewController(identifier: "EnterntainmentViewController") as! EnterntainmentViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell") as! ExploreTableViewCell
                if let section = getSection(by: "exploreAbuDhabi"),
                   let card = section.card {
                    let labelText = "\(section.title?.label ?? "") \(section.title?.highlight ?? "")"
                    cell.titleLabel.setStyledTextWithLastWordColor(fullText: labelText, lastWordColor: .blueColor)

                    let urlString = card.image?.url ?? ""
                    cell.bannerImageView.setImage(with: urlString, placeholder: UIImage.adgmPdg)
                    cell.downloadLabel.text = card.download?.label
                    
                    
                }
                return cell
            
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutAGDMTableViewCell") as! AboutAGDMTableViewCell
            
            if let section = getSection(by: "aboutADGM"),
                   let card = section.card {
                let labelText = "\(section.title?.label ?? "") \(section.title?.highlight ?? "")"
                cell.titleLabel.setStyledTextWithLastWordColor(fullText: labelText, lastWordColor: .blueColor)
                
                cell.titlebodyLabel.text = card.heading
                cell.bodyLabel.text = card.description
                let urlString = card.image?.url ?? ""
                cell.bannerImageView.setImage(with: urlString, placeholder: UIImage.adgmBanner)
                
                }
            cell.onClickViewAll = {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc  = story.instantiateViewController(identifier: "AboutADGMViewController") as! AboutADGMViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return self.view.frame.height / 4
        case 3:
            return 350
        case 4:
            return 375
        case 1:
            return 350
        default: return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 4 :
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let listVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
                self.navigationController?.pushViewController(listVC, animated: true)
            }
            
        default:
            print("hii")
        }
    }
    
}


extension HomeViewController: HomeSessionTableViewCellDelegate {
    
 
    func scheduleTableViewHeightUpdate() {
            pendingHeightUpdate?.cancel()
            let update = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                self.tableview.beginUpdates()
                self.tableview.endUpdates()
            }
            pendingHeightUpdate = update
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: update)
        }
    
    func homeSessionCellDidUpdateHeight() {
        scheduleTableViewHeightUpdate()
    }
}


extension HomeViewController: MenuSelectionDelegate {
    
    
    func didSelectMenuItem(_ item: String) {
       
        if item == "AgandaViewController" {
            tabBarController?.selectedIndex = 1
        } else if item == "TicketViewController" {
            tabBarController?.selectedIndex = 2
        } else {
            navigateTo(item)
        }
    }
    
    
    func navigateTo(_ id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK: API Calling




extension HomeViewController {
    
    
    func getSpeakerData(search: String?) {
        viewModel.fetchSpeakerLimitData(in: self.view, search: search, completion: {  [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let response):
                print("data",response)
              //  self.showNoDataView(false)
                self.arrayOfSpeaker = response
              //  self.filteredItems = response
             //   self.uniqueAgendaColors = self.extractUniqueAgendaColors(from: response)
                self.tableview.reloadData()
                                
            case .failure(let error):
                //self.showNoDataView(true)
              //  MessageHelper.showToast(message: failure.localizedDescription, in: self.view)
                MessageHelper.showBanner(message: error.localizedDescription, status: .error)
            }
            
            
        })
    }
    
    
    func getUpcommigSession() {
        homeViewModel.fetchHomeSessionData(page: 1, in: self.view, completion: { results in
            switch results {
            case .success(let response):
                print("data",response)
              //  self.showNoDataView(false)
                self.arrayOfSession = response
                self.tableview.reloadData()
                                
            case .failure(let error):
                //self.showNoDataView(true)
               // MessageHelper.showToast(message: failure.localizedDescription, in: self.view)
                MessageHelper.showBanner(message: error.localizedDescription, status: .error)
            }
            
            
        })
    }
    
    
    func fetchVenueData() {
        venueViewModel.fetchVenueData(in: self.view) { result in
            switch result {
            case .success(let venues):
                self.locations = venues
//                self.addLocationPins(from: venues)
//                self.zoomToFitAllAnnotations()
                self.tableview.reloadData()
            case .failure(let error):
                
                MessageHelper.showBanner(message: error.localizedDescription, status: .error)
            }
        }
    }
    
    func fetchFeaturedEvent() {
        featuredEventViewModel.fetchAgendas(in: self.view) { result in
            switch result {
            case .success(let agendas):
                self.featuredData = agendas
                self.tableview.reloadData()
            case .failure(let error):
                MessageHelper.showBanner(message: error.localizedDescription, status: .error)
            }
        }
    }
    
    func getPartnerData(page: Int) {

        partnerViewModel.fetchPartnerData(page: page,pageSize: 100, in: self.view) { result in
            switch result {
            case .success(let response):
                if let partners = response.data, !partners.isEmpty {
                    //self.partnerData = partners
                    self.mergePartnerData(partners)
                    self.tableview.reloadData()
                } else {
                MessageHelper.showToast(message: "No partner data available.", in: self.view)
                }
            case .failure(let error):
                MessageHelper.showBanner(message: error.localizedDescription, status: .error)
            }
        }
    }
    
    func mergePartnerData(_ partners: [Partner]) {
        var newCategoryDict: [String: String] = [:]

        for partner in partners {
            guard let label = partner.categories?.label,
                  let image = partner.websiteImage,
                  let url = URL(string: image),
                  !image.isEmpty else {
                continue
            }

            // Keep the first logo per category
            if newCategoryDict[label] == nil {
                newCategoryDict[label] = image
            }
        }

        // Convert to array for table view use
        let partnerSections = newCategoryDict.map { key, value in
            PartnerViewModels(title: key, logos: [value])
        }.sorted { $0.title < $1.title }
        // Assign to data source
        partnerViewModel.partnerSections = partnerSections
    }

    
    func getHomeBanner() {
        homeViewModel.fetchHomeBannerData(page: 1, in: self.view, completion: { results in
            switch results {
            case .success(let response):
                print("data",response)
              //  self.showNoDataView(false)
                self.homeData = response
                self.sidebarMenu = response.first?.attributes?.about_adgm?.first?.sidebarMenu
                self.section = response.first?.attributes?.about_adgm?.first?.page?.sections
                self.tableview.reloadData()
                                
            case .failure(let error):
                //self.showNoDataView(true)
                MessageHelper.showBanner(message: error.localizedDescription, status: .error)
            }
        })
    }

    
}
