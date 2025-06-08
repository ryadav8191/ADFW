//
//  HomeViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var notificationBell: UIButton!
    
    var banner = [BannerData(id: 1, image: "https://picsum.photos/200/300", orderIndex: 1, status: 1, createdAt: "", title: "", slug: ""),BannerData(id: 1, image: "https://picsum.photos/200/300", orderIndex: 1, status: 1, createdAt: "", title: "", slug: "")]
    
    var sideMenu: SideMenuNavigationController?
    private var pendingHeightUpdate: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Instantiate menu view controller from storyboard
        let menuVC = storyboard?.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
        menuVC.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menuVC)
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        sideMenu?.presentationStyle = .menuSlideIn
        sideMenu?.presentationStyle.backgroundColor = .black
        sideMenu?.presentationStyle.presentingEndAlpha = 0.5
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        registerCell()
        
        self.tableview.reloadData()
        tableview.showsVerticalScrollIndicator = false
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
    
    
    @IBAction func sideMenu(_ sender: Any) {
        if let menu = SideMenuManager.default.leftMenuNavigationController {
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell") as! BannerTableViewCell
            cell.banner = self.banner
            //  cell.delegate = self
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSessionTableViewCell") as! HomeSessionTableViewCell
            
            cell.configure(with: [], type: .session) // or .session
            cell.onClickViewAll = {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc  = story.instantiateViewController(identifier: "MajorEventViewController") as! MajorEventViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSessionTableViewCell") as! HomeSessionTableViewCell  //AboutAGDMTableViewCell
            cell.delegate = self
            cell.onClickViewAll = {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc  = story.instantiateViewController(identifier: "MajorEventViewController") as! MajorEventViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.configure(with: [], type: .event) // or .session
            
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ADFWMapTableViewCell") as! ADFWMapTableViewCell
            
            return cell
            
            
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSpeakerTableViewCell") as! HomeSpeakerTableViewCell  //AboutAGDMTableViewCell //EntertainmentTableViewCell
            
            cell.onClickViewAll = {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc  = story.instantiateViewController(identifier: "SpeakerViewController") as! SpeakerViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.delegate = self
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParterTableViewCell") as! ParterTableViewCell  //AboutAGDMTableViewCell //EntertainmentTableViewCell
            
            
            cell.onClickViewAll = {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc  = story.instantiateViewController(identifier: "OurPartnerViewController") as! OurPartnerViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EntertainmentTableViewCell") as! EntertainmentTableViewCell  //AboutAGDMTableViewCell //EntertainmentTableViewCell
            
            cell.onClickViewAll = {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc  = story.instantiateViewController(identifier: "EnterntainmentViewController") as! EnterntainmentViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell") as! ExploreTableViewCell
            
            return cell
            
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutAGDMTableViewCell") as! AboutAGDMTableViewCell
            
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
            return self.view.frame.height / 3
        case 3:
            return 350
        case 4:
            return 375
        default: return UITableView.automaticDimension
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
