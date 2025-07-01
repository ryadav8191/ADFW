//
//  ChatViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit

class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        configureUI()
       
    }
    
    func configureUI() {
        pageLabel.font = FontManager.font(weight: .semiBold, size: 19)
        
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
    }
    
    
    
    @IBAction func profileAction(_ sender: Any) {
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
   
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
   
    }
    
}
