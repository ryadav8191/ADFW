//
//  LoginViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var enterYourLabel: UILabel!
    @IBOutlet weak var ticketIdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var ticketTextField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
       
    }
    
    func configureUI() {
        welcomeLabel.font = FontManager.font(weight: .semiBold, size: 28)
        welcomeLabel.textColor = UIColor.blueColor
        
        enterYourLabel.font = FontManager.font(weight: .medium, size: 14)
        enterYourLabel.textColor = UIColor.grayColor
        
        ticketIdLabel.font = FontManager.font(weight: .medium, size: 16)
        ticketIdLabel.textColor = UIColor.blueColor
        
        nameLabel.font = FontManager.font(weight: .medium, size: 16)
        nameLabel.textColor = UIColor.blueColor
        
        backButton.isHidden = true
        
        ticketTextField.font = FontManager.font(weight: .medium, size: 16)
        NameTextField.font = FontManager.font(weight: .medium, size: 16)
        
        loginButton.titleLabel?.font = FontManager.font(weight: .semiBold, size: 16)
    }
    
    @IBAction func backAction(_ sender: Any) {
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
    }
    

}
