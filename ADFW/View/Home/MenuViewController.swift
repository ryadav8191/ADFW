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
    weak var delegate: MenuSelectionDelegate?
    var sidebarMenu : SidebarMenu?

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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGesture)
        
        nameLabel.font = FontManager.font(weight: .medium, size: 19)
        nameLabel.textColor = UIColor.black
        
        companyLabel.font = FontManager.font(weight: .semiBold, size: 13)
        companyLabel.textColor = UIColor.grayColor
        tableView.showsVerticalScrollIndicator = false
        
        nameLabel.text = (LocalDataManager.getLoginResponse()?.firstName ?? "") + " "  + (LocalDataManager.getLoginResponse()?.lastName ?? "")
        companyLabel.text = LocalDataManager.getLoginResponse()?.designation
        
        
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

    override func viewWillAppear(_ animated: Bool) {
        let photo = LocalDataManager.getLoginResponse()?.photo
        if let urlString = photo , let photoUrl = URL(string: urlString) {
            profileImageView.kf.setImage(with: photoUrl, placeholder: UIImage(named: "profile"))
        } else {
            profileImageView.image = UIImage(named: "profile")
        }
    }
    
    @objc func imageTapped() {
        print("Image tapped!")

        dismiss(animated: true) {
            self.delegate?.didSelectMenuItem("ProfileViewController")
        }
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
        if let itemsCount = sidebarMenu?.navigationItems?.count {
            return itemsCount + 2 // +1 for footer or additional cell
        } else {
            return 1 // Return 1 for footer or a default cell
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (sidebarMenu?.navigationItems?.count ?? 0) + 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuFooterTableViewCell", for: indexPath) as! MenuFooterTableViewCell
//            cell.openURL = { [weak self] url in
//                if let link = URL(string: url) {
//                    UIApplication.shared.open(link)
//                }
//            }
            let data = sidebarMenu?.support
            cell.helpLabel.text = data?.text
            cell.emailLabel.text = data?.email
            cell.setupSocialButtons(with: sidebarMenu?.socialMedia ?? [])
            
            
            return cell
        }
        else if indexPath.row == sidebarMenu?.navigationItems?.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell", for: indexPath) as! MenuItemTableViewCell
            cell.topBorder.isHidden = false
            cell.bottomBorder.isHidden = false
            if let data = sidebarMenu?.signOut {
                cell.titleLabel.text = data.label
                cell.titleLabel.font = FontManager.font(weight: .medium, size: 16)
                cell.iconImageView.setImage(with: data.icon, placeholder: UIImage(systemName: "globe"))
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell", for: indexPath) as? MenuItemTableViewCell else {
                return UITableViewCell()
            }
            
//            if let itemCount = sidebarMenu?.navigationItems?.count, indexPath.row == itemCount - 1 {
//                cell.topBorder.isHidden = false
//                cell.bottomBorder.isHidden = false
//            } else {
                cell.topBorder.isHidden = true
                cell.bottomBorder.isHidden = true
//            }

            
            if let item = sidebarMenu?.navigationItems?[indexPath.row] {
                   cell.titleLabel.text = item.label
                   cell.titleLabel.font = FontManager.font(weight: .medium, size: 16)
                   cell.iconImageView.setImage(with: item.icon, placeholder: UIImage(systemName: "globe"))
                   // cell.badgeView.isHidden = !item.hasBadge
               } else {
                   cell.titleLabel.text = ""
                   cell.iconImageView.image = nil
               }
            
            
            // cell.badgeView.isHidden = !item.hasBadge
            
            return cell
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let itemCount = sidebarMenu?.navigationItems?.count {
            if indexPath.row == itemCount + 1{
                return 200 // Footer cell height
            } else if indexPath.row == itemCount {
                return 86
            } else {
                return 50
            }
        } else {
            return 50
        }
    }

//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//     dismiss(animated: true) {
//               // handle navigation
//               switch indexPath.row {
//               case 0:
//                   self.delegate?.didSelectMenuItem("ProfileViewController")
//               case 1:
//                   self.delegate?.didSelectMenuItem("TicketViewController")
//               case 2:
//                   self.delegate?.didSelectMenuItem("AgandaViewController")
//               case 3: 
//                   self.delegate?.didSelectMenuItem("SocialMediaActivityViewController")
//            case 4:
//                   self.delegate?.didSelectMenuItem("MapViewController")
//               case 6:
//                   self.delegate?.didSelectMenuItem("InterestViewController")
//               case 7: self.showSuccessPopupAndNavigate()
//               default: break
//               }
//           }
//       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let items = sidebarMenu?.navigationItems else { return }
        
        // Footer cell (support)
        if indexPath.row == items.count + 1 {
            return
        }
        
        // Logout cell
        if indexPath.row == items.count {
            dismiss(animated: true) {
                self.showSuccessPopupAndNavigate()
             
            }
            return
        }
        
        // Regular navigation item
        let selectedItem = items[indexPath.row]
        
        dismiss(animated: true) {
            // You can customize this if you want to map "target" to view controller identifiers
            self.delegate?.didSelectMenuItem(self.viewControllerID(for: selectedItem.target ?? ""))
        }
    }

    
    func viewControllerID(for target: String) -> String {
        switch target {
        case "profile": return "ProfileViewController"
        case "ticket": return "TicketViewController"
        case "agenda": return "AgandaViewController"
        case "social-feed": return "SocialMediaActivityViewController"
        case "map": return "MapViewController"
        case "favourites": return "FavouriteViewController"
        case "interests": return "InterestViewController"
        default: return "ProfileViewController" // fallback
        }
    }


    func navigateTo(_ id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .fullScreen
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            rootVC.present(vc, animated: true, completion: nil)
        }
    }

    
    func logoutUser() {
            print("Logging out...")
        }

    
    func showSuccessPopupAndNavigate() {
        guard let window = UIApplication.shared.windows.first,
              let rootVC = window.rootViewController else { return }

        // 1. Add Blur View
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0
        blurView.frame = rootVC.view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rootVC.view.addSubview(blurView)

        // 2. Add Popup
        let popup = SuccessPopupView()
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.alpha = 0
        rootVC.view.addSubview(popup)

        NSLayoutConstraint.activate([
            popup.centerXAnchor.constraint(equalTo: rootVC.view.centerXAnchor),
            popup.centerYAnchor.constraint(equalTo: rootVC.view.centerYAnchor),
            popup.widthAnchor.constraint(equalToConstant: 300),
            popup.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])

        // 3. Animate blur + popup
        UIView.animate(withDuration: 0.3) {
            blurView.alpha = 1
            popup.alpha = 1
        }

        // 4. Dismiss after delay and navigate to login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            UIView.animate(withDuration: 0.3, animations: {
                blurView.alpha = 0
                popup.alpha = 0
            }) { _ in
                blurView.removeFromSuperview()
                popup.removeFromSuperview()
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                LocalDataManager.clearLoginResponse()
              
                let loginVC = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "LoginViewController")

                let nav = UINavigationController(rootViewController: loginVC)
                nav.modalPresentationStyle = .fullScreen
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
        }
    }





    
}
