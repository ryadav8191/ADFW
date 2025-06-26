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
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ticketTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var validTicketLabel: UILabel! 
    @IBOutlet weak var validLastNameLabel: UILabel!
    
    var viewModel = LoginViewModel()
    
    var countries: [CountryAttributes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
       
       // fetchCountries()
    }
    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentInsetAdjustmentBehavior = .never
        self.navigationController?.navigationBar.isHidden = true
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
        lastNameTextField.font = FontManager.font(weight: .medium, size: 16)
        
        loginButton.titleLabel?.font = FontManager.font(weight: .semiBold, size: 16)
        
        validTicketLabel.font = FontManager.font(weight: .medium, size: 14)
        validLastNameLabel.font = FontManager.font(weight: .medium, size: 14)
        
        validLastNameLabel.textColor = UIColor.red
        validTicketLabel.textColor = UIColor.red
        
        ticketTextField.delegate = self
        lastNameTextField.delegate = self
        
        
    }
    
    @IBAction func backAction(_ sender: Any) {
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        self.view.endEditing(true)
        guard let ticketNumber = ticketTextField.text, !ticketNumber.trimmingCharacters(in: .whitespaces).isEmpty else {
              // MessageHelper.showAlert(message: "Please enter your Ticket ID.", on: self)
            validTicketLabel.text = "Please enter your Ticket ID."
               return
           }
        
        guard let lastName = lastNameTextField.text, !lastName.trimmingCharacters(in: .whitespaces).isEmpty else {
           // MessageHelper.showAlert(message: "Please enter your Last Name.", on: self)
            validLastNameLabel.text = "Please enter your Last Name."
               return
           }
        
        viewModel.loginWithTicket(
            lastName: lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            ticketNumber: ticketTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            in: self.view
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    
                    LocalDataManager.saveLoginResponse(user)
                    LocalDataManager.saveId(userId: user.id ?? 0)
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeVC = storyboard.instantiateViewController(withIdentifier: "InterestViewController") as! InterestViewController
                    self.navigationController?.pushViewController(homeVC, animated: true)
                    
                    MessageHelper.showBanner(message: "Suessessfully login", status: .success)
                   
                case .failure(let error):
                    MessageHelper.showBanner(message: error.localizedDescription, status: .error)
                    
                }
            }
        }
        
    }
    
    
   
    
   

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        validTicketLabel.text = ""
        validLastNameLabel.text = ""
        return true
    }
    
}
