//
//  ExploreViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit

class ExploreViewController: UIViewController {

    let categoryPopup = CategoryPopupView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupCategoryPopup()
    }

    func setupCategoryPopup() {
        categoryPopup.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryPopup)

        NSLayoutConstraint.activate([
            categoryPopup.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryPopup.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            categoryPopup.widthAnchor.constraint(equalToConstant: 350)
        ])

        categoryPopup.onFoodTap = {
            print("Food @ ADFW tapped")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }

        categoryPopup.onEntertainmentTap = {
            print("Entertainment @ ADFW tapped")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "EnterntainmentViewController") as! EnterntainmentViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
