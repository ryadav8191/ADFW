//
//  MainTabBarController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//


import UIKit

class CustomTabBarController: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
       
        self.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           addTabBarShadow()
       }
    
    
    private func addTabBarShadow() {
        tabBar.layer.shadowColor = UIColor(red: 0, green: 38/255, blue: 70/255, alpha: 0.15).cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 6
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.masksToBounds = false
        tabBar.backgroundColor = .white

        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.shadowColor = UIColor(red: 0, green: 38/255, blue: 70/255, alpha: 0.15)
            appearance.shadowImage = nil

            // 👇 Add these lines
            appearance.stackedLayoutAppearance.normal.iconColor = .black
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(hex: "#1B6AD5")
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(hex: "#1B6AD5")]

            tabBar.standardAppearance = appearance

            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        }

        // Safe to keep these too
        tabBar.tintColor = UIColor(hex: "#1B6AD5")
        tabBar.unselectedItemTintColor = .black
    }



    
    private func setupTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeVC = createNavController(vc: storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController, title: "Home", icon: UIImage.home)
        
        let agandaVC = storyboard.instantiateViewController(withIdentifier: "MajorEventViewController") as! MajorEventViewController
        let conferenceNav = createNavController(vc: agandaVC, title: "Agenda", icon: UIImage.agenda)
        
        let ticketVC = storyboard.instantiateViewController(withIdentifier: "TicketViewController") as! TicketViewController
        ticketVC.pageType = .push
        let travelNav = createNavController(vc: ticketVC, title: "Ticket", icon: UIImage.ticket)
        
        let chatVC = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        let interactionNav = createNavController(vc: chatVC, title: "Chat", icon: UIImage.chat)
        
        let exploreVC = storyboard.instantiateViewController(withIdentifier: "ExploreViewController") as! ExploreViewController
        
        let exploreNav = createNavController(vc: exploreVC, title: "Explore", icon: UIImage.explore)

        viewControllers = [homeVC, conferenceNav, travelNav, interactionNav,exploreNav]
        // Tab Bar Customization (Optional)
        tabBar.tintColor = UIColor(hex: "#1B6AD5") // Selected icon color
        tabBar.unselectedItemTintColor = .black // Unselected icon color
      
    }

    private func createNavController(vc: UIViewController, title: String, icon: UIImage) -> UINavigationController {
        vc.title = title
        vc.tabBarItem.image = icon.withRenderingMode(.alwaysTemplate)
        return UINavigationController(rootViewController: vc)
        
    }
    
   
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        
       
        if let navController = viewController as? UINavigationController {
            // Clear the stack and go to the root view controller
            navController.popToRootViewController(animated: false)
        } else {
            // If it's not a navigation controller, just return true to select the tab
            return true
        }
        
        
        
        if let index = viewControllers?.firstIndex(of: viewController), index == 4 {
//               showCategoryPopup()
               return true
           }
        
        return true
    }
    
    
    
    func showCategoryPopup() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
            .first else { return }

        let dimmingView = UIView(frame: window.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimmingView.isUserInteractionEnabled = true

        let popup = CategoryPopupView()
        popup.translatesAutoresizingMaskIntoConstraints = false

       
        popup.onFoodTap = {
            print("Food @ ADFW tapped")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FoodViewController") as? FoodViewController

            if let tabBar = self as? UITabBarController,
               let selectedNav = tabBar.selectedViewController as? UINavigationController {
                selectedNav.pushViewController(vc!, animated: true)
            }

            dimmingView.removeFromSuperview()
        }


        popup.onEntertainmentTap = {
            print("Entertainments tapped")
            dimmingView.removeFromSuperview()
        }

        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissPopup(_:))))
        window.addSubview(dimmingView)
        dimmingView.addSubview(popup)

        NSLayoutConstraint.activate([
            popup.centerXAnchor.constraint(equalTo: dimmingView.centerXAnchor),
            popup.centerYAnchor.constraint(equalTo: dimmingView.centerYAnchor),
            popup.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    @objc func dismissPopup(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }

    
}
