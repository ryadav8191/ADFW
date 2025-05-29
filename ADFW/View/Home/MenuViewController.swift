//
//  MenuViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
       @IBOutlet weak var nameLabel: UILabel!
       @IBOutlet weak var companyLabel: UILabel!
       @IBOutlet weak var tableView: UITableView!
    
    var menuItems: [MenuItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfile()
        setupMenuItems()
        setupTableView()
    }
    

    func setupProfile() {
          profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
          profileImageView.clipsToBounds = true
          profileImageView.image = UIImage.profile
          nameLabel.text = "Shoaib Muhammed"
          companyLabel.text = "CPI Business"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGesture)
        
        nameLabel.font = FontManager.font(weight: .medium, size: 19)
        nameLabel.textColor = UIColor.black
        
        companyLabel.font = FontManager.font(weight: .semiBold, size: 13)
        companyLabel.textColor = UIColor.grayColor
      }
    
    func setupMenuItems() {
           menuItems = [
            MenuItem(icon: UIImage.user, title: "My Profile", hasBadge: false),
            MenuItem(icon: UIImage.ticketSide, title: "My Ticket", hasBadge: false),
            MenuItem(icon: UIImage.agandaSidemenu, title: "Agenda", hasBadge: false),
            MenuItem(icon: UIImage.chat, title: "Social Feed", hasBadge: true),
            MenuItem(icon:UIImage.calendar, title: "ADFW Map", hasBadge: false),
            MenuItem(icon: UIImage.favourites, title: "Favourites", hasBadge: false),
            MenuItem(icon: UIImage.interests, title: "Interests", hasBadge: false),
            MenuItem(icon: UIImage.signOut, title: "Sign Out", hasBadge: false)
           ]
       }

    
    @objc func imageTapped() {
        print("Image tapped!")

//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
//
//            let navController = UINavigationController(rootViewController: profileVC)
//            navController.modalPresentationStyle = .fullScreen // optional
//            self.present(navController, animated: false, completion: nil)
//        }
    }


    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "MenuItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuItemTableViewCell")
        tableView.register(UINib(nibName: "MenuFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuFooterTableViewCell")
        
        
    }
   

}


extension MenuViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuItems.count + 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

          
            
            if indexPath.row == menuItems.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuFooterTableViewCell", for: indexPath) as! MenuFooterTableViewCell
                cell.openURL = { [weak self] url in
                    if let link = URL(string: url) {
                        UIApplication.shared.open(link)
                    }
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell", for: indexPath) as? MenuItemTableViewCell else {
                    return UITableViewCell()
                }

                let item = menuItems[indexPath.row]
                cell.titleLabel.text = item.title
                cell.titleLabel.font = FontManager.font(weight: .medium, size: 16)
                cell.iconImageView.image = item.icon
               // cell.badgeView.isHidden = !item.hasBadge

                return cell
                
            }

            
            
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == menuItems.count {
            return 200 // Footer cell height
        } else {
            return 50  // Regular menu item cell height
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           dismiss(animated: true) {
               // handle navigation
               switch indexPath.row {
               case 0: self.navigateTo("OurPartnerViewController") 
               case 1: self.navigateTo("TicketViewController")
               case 2: self.navigateTo("MajorEventViewController")
               case 3: self.navigateTo("SocialMediaActivityViewController")
              case 4: self.navigateTo("AboutADGMViewController")
//               case 5: self.navigateTo("SpeakerViewController")
               case 6: self.navigateTo("InterestViewController")
//              case 7: self.navigateTo("")
//               case 8: self.logoutUser()
               default: break
               }
           }
       }

    func navigateTo(_ id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .fullScreen

        // Optional: present from top view controller safely
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            rootVC.present(vc, animated: true, completion: nil)
        }
    }

    
    func logoutUser() {
            print("Logging out...")
        }


    
}
