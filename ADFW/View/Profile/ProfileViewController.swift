//
//  ProfileViewController.swift
//  ADFW
//
//  Created by MultiTV on 19/05/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var MyProfileLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bussinessLabel: UILabel!
    @IBOutlet weak var ticketLabel: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var designationTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var submitButtonView: UIView!
    @IBOutlet weak var submitButtonLabel: UILabel!
    @IBOutlet weak var disclaimerLabel: UILabel!
    @IBOutlet weak var customNavigationView: UIView!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var openToNetWork: UILabel!
    
    var isSwitchOn = false
    var isChecked: Bool = false
    var isEditingEnabled = true

    //MARK: -- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        configureUI()
        submitButtonTapped()
    }
    
    override func viewDidLayoutSubviews() {
        customNavigationView.layer.shadowPath = UIBezierPath(rect: customNavigationView.bounds).cgPath

    }
    
    func configureUI() {
        firstNameLabel.font = FontManager.font(weight: .medium, size: 14)
        firstNameLabel.textColor = UIColor.grayColor
        
        lastNameLabel.font = FontManager.font(weight: .medium, size: 14)
        lastNameLabel.textColor = UIColor.grayColor
        
        companyLabel.font = FontManager.font(weight: .medium, size: 14)
        companyLabel.textColor = UIColor.grayColor
        
        designationLabel.font = FontManager.font(weight: .medium, size: 14)
        designationLabel.textColor = UIColor.grayColor
        
        emailLabel.font = FontManager.font(weight: .regular, size: 14)
        emailLabel.textColor = UIColor.grayColor
        
        phoneNumberLabel.font = FontManager.font(weight: .regular, size: 14)
        phoneNumberLabel.textColor = UIColor.grayColor
        
        firstNameTextField.font = FontManager.font(weight: .regular, size: 14)
        firstNameTextField.textColor = UIColor.blueColor
        
        lastNameTextField.font = FontManager.font(weight: .regular, size: 14)
        lastNameTextField.textColor = UIColor.blueColor
        
        designationTextField.font = FontManager.font(weight: .regular, size: 14)
        designationTextField.textColor = UIColor.blueColor
        
        emailTextField.font = FontManager.font(weight: .regular, size: 14)
        emailTextField.textColor = UIColor.blueColor
        
        phoneNumberTextField.font = FontManager.font(weight: .regular, size: 14)
        phoneNumberTextField.textColor = UIColor.blueColor
        
        companyTextField.font = FontManager.font(weight: .regular, size: 14)
        companyTextField.textColor = UIColor.blueColor
        
        MyProfileLabel.font = FontManager.font(weight: .semiBold, size: 18)
        MyProfileLabel.textColor = UIColor.black
        
        nameLabel.font = FontManager.font(weight: .semiBold, size: 21)
        nameLabel.textColor = UIColor.black
        
        bussinessLabel.font = FontManager.font(weight: .semiBold, size: 13)
        bussinessLabel.textColor = UIColor.grayColor
        
        ticketLabel.font = FontManager.font(weight: .medium, size: 14)
        ticketLabel.textColor = UIColor.grayColor
        
        openToNetWork.font = FontManager.font(weight: .medium, size: 14)
        openToNetWork.textColor = UIColor.black
        
        customNavigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        customNavigationView.layer.shadowOpacity = 0.25
        customNavigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        customNavigationView.layer.shadowRadius = 1
        customNavigationView.layer.masksToBounds = false
        
        submitButtonView.layer.borderColor = UIColor.grayColor.cgColor
        submitButtonView.layer.borderWidth = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(submitButtonTapped))
        submitButtonView.addGestureRecognizer(tapGesture)
        submitButtonView.isUserInteractionEnabled = true


       
    }
    
    
    func updateCheckboxImage() {
        let imageName = isChecked ?  UIImage.checkbox: UIImage.unchecked
        checkBoxButton.setImage(imageName, for: .normal)
    }
    
    @objc func submitButtonTapped() {
        isEditingEnabled.toggle()

        // Toggle all editable fields
        firstNameTextField.isEnabled = isEditingEnabled
        lastNameTextField.isEnabled = isEditingEnabled
        companyTextField.isEnabled = isEditingEnabled
        designationTextField.isEnabled = isEditingEnabled
        emailTextField.isEnabled = isEditingEnabled
        phoneNumberTextField.isEnabled = isEditingEnabled
        checkBoxButton.isEnabled = isEditingEnabled
        mySwitch.isEnabled = isEditingEnabled

        // Optionally: Update the submit button label to reflect state
        submitButtonLabel.text = isEditingEnabled ? "SAVE" : "UPDATE PROFILE"
    }

    
    

    //MARK: -- Button Action
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    
    
    @IBAction func switchoffButton(_ sender: Any) {
        isSwitchOn.toggle()
          let newImage = isSwitchOn ? UIImage.switchOn : UIImage.switchOff
          UIView.transition(with: switchButton,
                            duration: 0.3,
                            options: .transitionCrossDissolve,
                            animations: {
                                self.switchButton.setImage(newImage, for: .normal)
                            },
                            completion: nil)
    }
    
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("Switch is ON")
            // Do something for ON state
        } else {
            print("Switch is OFF")
            // Do something for OFF state
        }
    }
    
    
    @IBAction func checkBoxAction(_ sender: Any) {
        isChecked.toggle()
          updateCheckboxImage()
        
    }
    
}
