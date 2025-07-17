//
//  ProfileViewController.swift
//  ADFW
//
//  Created by MultiTV on 19/05/25.
//

import UIKit
import CountryPickerView
import Kingfisher

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
    @IBOutlet weak var loginbuttonArrowImageView: UIImageView!
    @IBOutlet weak var updateStatusLabel: UILabel!
    @IBOutlet weak var updateStatusView: UIView!
    
    
    @IBOutlet weak var updateProfileViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var countryPickerView: UIView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var updateViewheightConst: NSLayoutConstraint!
    @IBOutlet weak var saveButtonHeightConst: NSLayoutConstraint!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var dropDown: UIImageView!
    
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var countryCodePicker: UIButton!
    @IBOutlet weak var updateUserProfileButton: UIButton!
    @IBOutlet weak var mainContainerView: UIView!
    
    
    var isSwitchOn = false
    var isChecked: Bool = false
    var isEditingEnabled = false
    
    var viewModel = UpdateUserViewModel()
    var countries: [CountryAttributes] = []
    var countryViewModel =  CountryViewModel()
    var uploadfileViewModel = UploadFileViewModel()
    private var blurView: UIVisualEffectView?
    var slectedImage:String?
    
    //MARK: -- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureUI()
        if let data = LocalDataManager.getLoginResponse() {
            configureData(data: data)
        }
        
        let photo = LocalDataManager.getLoginResponse()?.photo
        
        if let urlString = photo , let photoUrl = URL(string: urlString) {
            profileImageView.kf.setImage(with: photoUrl, placeholder: UIImage(named: "profile"))
        } else {
            profileImageView.image = UIImage(named: "profile")
        }
        
        submitButtonTapped()
        updateStatusView.isHidden = true
        
//        countryPickerView.delegate = self
//        countryPickerView.dataSource = self
//        countryPickerView.showCountryCodeInView = false
//        countryPickerView.showCountryNameInView = false
//        countryPickerView.showPhoneCodeInView = true
//        countryPickerView.countryDetailsLabel.font = FontManager.font(weight: .regular, size: 14)
//        countryPickerView.flagImageView.contentMode = .scaleAspectFit
//        countryPickerView.flagImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
//        countryPickerView.flagImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
//        countryPickerView.flagSpacingInView = 4
       // countryPickerView.showCountriesList(from: self)
        
        fetchCountries()
    }
    
    override func viewDidLayoutSubviews() {
        customNavigationView.layer.shadowPath = UIBezierPath(rect: customNavigationView.bounds).cgPath

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func configureUI() {
        firstNameLabel.font = FontManager.font(weight: .medium, size: 14)
        firstNameLabel.textColor = UIColor.grayColor
        
        updateStatusLabel.font = FontManager.font(weight: .medium, size: 15)
        
        lastNameLabel.font = FontManager.font(weight: .medium, size: 14)
        lastNameLabel.textColor = UIColor.grayColor
        
        companyLabel.font = FontManager.font(weight: .medium, size: 14)
        companyLabel.textColor = UIColor.grayColor
        
        codeLabel.font = FontManager.font(weight: .medium, size: 14)
        codeLabel.textColor = UIColor.grayColor
        
        
        designationLabel.font = FontManager.font(weight: .medium, size: 14)
        designationLabel.textColor = UIColor.grayColor
        
        emailLabel.font = FontManager.font(weight: .regular, size: 14)
        emailLabel.textColor = UIColor.grayColor
        
        phoneNumberLabel.font = FontManager.font(weight: .regular, size: 14)
        phoneNumberLabel.textColor = UIColor.grayColor
        
        firstNameTextField.font = FontManager.font(weight: .medium, size: 14)
        firstNameTextField.textColor = UIColor.blueColor
        
        lastNameTextField.font = FontManager.font(weight: .medium, size: 14)
        lastNameTextField.textColor = UIColor.blueColor
        
        designationTextField.font = FontManager.font(weight: .medium, size: 14)
        designationTextField.textColor = UIColor.blueColor
        
        emailTextField.font = FontManager.font(weight: .medium, size: 14)
        emailTextField.textColor = UIColor.blueColor
        
        phoneNumberTextField.font = FontManager.font(weight: .medium, size: 14)
        phoneNumberTextField.textColor = UIColor.blueColor
        
        companyTextField.font = FontManager.font(weight: .medium, size: 14)
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
        
        
        
        countryCodeLabel.font = FontManager.font(weight: .medium, size: 14)
        countryCodeLabel.textColor = UIColor.blueColor
        
        mainContainerView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        mainContainerView.layer.shadowOpacity = 0.25
        mainContainerView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        mainContainerView.layer.shadowRadius = 1
        mainContainerView.layer.masksToBounds = false
        
       // mainContainerView.applyBoxShadow()
        
        submitButtonView.layer.borderColor = UIColor.grayColor.cgColor
        submitButtonView.layer.borderWidth = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(submitButtonTapped))
        submitButtonView.addGestureRecognizer(tapGesture)
        submitButtonView.isUserInteractionEnabled = true
        
        editView.layer.cornerRadius = editView.frame.height / 2
        
        profileView.layer.cornerRadius = profileView.frame.height / 2
            profileView.clipsToBounds = true
        
    }
    
    func configureData(data: User) {
        
        nameLabel.text = (data.firstName ?? "") + " " + (data.lastName ?? "")
        
        firstNameTextField.text = data.firstName ?? ""
        lastNameTextField.text = data.lastName ?? ""
        bussinessLabel.text = data.designation
       
        companyTextField.text = data.company
        designationTextField.text = data.designation
        emailTextField.text = data.email
        phoneNumberTextField.text = data.mobile ?? ""
        
        let ticketNumber = data.ticketNumber ?? ""
        let fullText = "Ticket ID: \(ticketNumber)"

        // Create attributed string
        let attributedText = NSMutableAttributedString(string: fullText)
        let ticketNumberRange = (fullText as NSString).range(of: ticketNumber)
        attributedText.addAttribute(.font, value: FontManager.font(weight: .bold, size: 12), range: ticketNumberRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.grayColor, range: ticketNumberRange)
        let labelRange = (fullText as NSString).range(of: "Ticket ID:")
        attributedText.addAttribute(.font, value: FontManager.font(weight: .medium, size: 12), range: labelRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.grayColor, range: labelRange)
        // Assign to label
        ticketLabel.attributedText = attributedText
        
        let phoneCodeFromAPI = data.countryCode ?? ""
        let formattedCode = phoneCodeFromAPI.hasPrefix("+") ? phoneCodeFromAPI : "+\(phoneCodeFromAPI)"
        countryCodeLabel.text = formattedCode
        
        if let isoCode = getISOCode(fromPhoneCode: phoneCodeFromAPI) {
         
            countryViewModel.loadFlagImage(for: isoCode) { image in
                self.countryImageView.image = image
            }
        }
        isChecked = data.isTermsAgreed ?? false
        updateCheckboxImage()
        
    }
    
    
    func validateFields() -> Bool {
        // Trim whitespace and check if fields are empty
        guard let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstName.isEmpty else {
            MessageHelper.showBanner(message: "Please enter your first name.", status: .error)
            return false
        }
        
        guard let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !lastName.isEmpty else {
            MessageHelper.showBanner(message: "Please enter your last name.", status: .error)
            return false
        }

        guard let company = companyTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !company.isEmpty else {
            MessageHelper.showBanner(message: "Please enter your company name.", status: .error)
            return false
        }

        guard let designation = designationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !designation.isEmpty else {
            MessageHelper.showBanner(message: "Please enter your designation.",status: .error)
            return false
        }

        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), isValidEmail(email) else {
            MessageHelper.showBanner(message: "Please enter a valid email address.", status: .error)
            return false
        }

        guard let phone = phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !phone.isEmpty else {
            MessageHelper.showBanner(message: "Please enter a phone number.", status: .error)
            return false
        }

        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

  

    func getISOCode(fromPhoneCode code: String) -> String? {
        let picker = CountryPickerView()
        if let country = picker.countries.first(where: { $0.phoneCode == "+\(code)" }) {
            return country.code // e.g., "AE"
        }
        return nil
    }
 
    
    
    func updateCheckboxImage() {
        let imageName = isChecked ?  UIImage.checkbox: UIImage.unchecked
        checkBoxButton.setImage(imageName, for: .normal)
    }
    
    @objc func submitButtonTapped() {
        isEditingEnabled.toggle()
        if isEditingEnabled {
                isEditingEnabled = true

                
               firstNameTextField.isEnabled = false
                lastNameTextField.isEnabled = false
                companyTextField.isEnabled = false
                designationTextField.isEnabled = false
                emailTextField.isEnabled = false
                phoneNumberTextField.isEnabled = false
                checkBoxButton.isEnabled = false
                //mySwitch.isEnabled = false
            countryCodePicker.isUserInteractionEnabled = false
            updateUserProfileButton.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.3) {
                self.saveButton.alpha = 0
                self.submitButtonView.alpha = 1
                self.updateViewheightConst.constant = 50
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.saveButton.isHidden = true
                self.submitButtonView.isHidden = false
            }

        } else {

            firstNameTextField.isEnabled = true
            lastNameTextField.isEnabled = true
            companyTextField.isEnabled = true
            designationTextField.isEnabled = true
            emailTextField.isEnabled = true
            phoneNumberTextField.isEnabled = true
            checkBoxButton.isEnabled = true
         //   mySwitch.isEnabled = false
            countryCodePicker.isUserInteractionEnabled = true
            updateUserProfileButton.isUserInteractionEnabled = true
            self.saveButton.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.saveButton.alpha = 1
                self.submitButtonView.alpha = 0
                self.updateViewheightConst.constant = 0
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.submitButtonView.isHidden = true
            }

            
          //  submitButtonLabel.text = "UPDATE PROFILE"
          //  submitButtonView.backgroundColor = UIColor.clear
          //  submitButtonLabel.textColor = UIColor.gray
           // loginbuttonArrowImageView.tintColor = UIColor.gray
        }
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available")
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.modalPresentationStyle = .overFullScreen

        present(picker, animated: true)
    }

    func openGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.modalPresentationStyle = .overFullScreen
        present(picker, animated: true)
    }


    
    
    @IBAction func selectCountryTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pickerVC = storyboard.instantiateViewController(withIdentifier: "CountryPickerViewController") as! CountryPickerViewController

        pickerVC.countries = self.countries

        pickerVC.onCountrySelected = { [weak self] selected in
            guard let self = self,
                  let flagCode = selected.flag?.lowercased(),
                  let code = selected.code else { return }
            countryViewModel.loadFlagImage(for: flagCode) { image in
                self.countryImageView.image = image
            }
            self.countryCodeLabel.text = "+\(code)"
        }



        if #available(iOS 15.0, *) {
            if let sheet = pickerVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]  // Allows dragging to expand
                sheet.prefersGrabberVisible = true     // Shows grabber handle
                sheet.preferredCornerRadius = 20       // Rounded corners
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            pickerVC.modalPresentationStyle = .pageSheet
        } else {
            pickerVC.modalPresentationStyle = .overFullScreen // fallback for < iOS 15
        }

        present(pickerVC, animated: true)

       }

       func flagEmoji(from countryCode: String) -> String {
           countryCode.uppercased()
               .unicodeScalars
               .compactMap { UnicodeScalar(127397 + $0.value) }
               .map { String($0) }
               .joined()
       }
    
    func presentImagePickerSheet() {
        // 1. Create and add blur view
        let blurEffect = UIBlurEffect(style: .dark)
        let blur = UIVisualEffectView(effect: blurEffect)
        blur.frame = view.bounds
        blur.alpha = 0.6
        view.addSubview(blur)
        self.blurView = blur
        
        // 2. Setup image picker popup
        let pickerVC = ImagePickerViewController()
        pickerVC.modalPresentationStyle = .custom
        pickerVC.transitioningDelegate = self
        
        // 3. Camera action
        pickerVC.cameraAction = { [weak self] in
            pickerVC.dismiss(animated: true) {
                self?.blurView?.removeFromSuperview()
                self?.blurView = nil
                self?.openCamera()
            }
        }
        
        // 4. Gallery action
        pickerVC.galleryAction = { [weak self] in
            pickerVC.dismiss(animated: true) {
                self?.blurView?.removeFromSuperview()
                self?.blurView = nil
                self?.openGallery()
            }
        }
        
        // 5. Blur cleanup
        pickerVC.onDismiss = { [weak self] in
            self?.blurView?.removeFromSuperview()
            self?.blurView = nil
        }
        
        // 6. Present popup
        present(pickerVC, animated: true)
    }


    //MARK: -- Button Action
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        guard validateFields() else { return }
        let userId = LocalDataManager.getUserId()
        let parameters: [String: Any] = [
            "firstName": firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "lastName": lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "email": emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "company": companyTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "designation": designationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            //   "phoneNumber": phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "mobile": phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "countryCode": countryCodeLabel.text ?? "",
            "photo": self.slectedImage == nil ? LocalDataManager.getLoginResponse()?.photo : "" ,
            // "image1": LocalDataManager.getLoginResponse()?.photo ?? "",
            
        ]
        viewModel.updateUserProfile(userId: userId, parameters: parameters, in: self.view) { result in
            switch result {
            case .success(let response):
              
                if let data = response?.attributes, let id = response?.id {
                    LocalDataManager.saveLoginResponse(data)
                    LocalDataManager.saveId(userId: id)
                    self.configureData(data: data)
                    MessageHelper.showBanner(message: "Profile updated successfully", status: .success)
                } else {
                    MessageHelper.showBanner(message: NetworkError.noData.localizedDescription, status: .error)
                }
               
              
            case .failure(let error):
                MessageHelper.showBanner(message: error.localizedDescription, status: .error)


            }
        }
    }
    
    
   
    @IBAction func updateAction(_ sender: Any) {
        presentImagePickerSheet()
    }
    
    
    
    

    
    func fetchCountries() {
        countryViewModel.fetchCountries(in: self.view) { result in
            switch result {
            case .success(let countries):
                print("✅ Countries:", countries)
                 self.countries = countries
                // self.countryPicker.reloadAllComponents()
            case .failure(let error):
                MessageHelper.showAlert(message: error.localizedDescription, on: self)
            }
        }
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
            self.uploadFile(image: image)
        }

        picker.dismiss(animated: true) { [weak self] in
            self?.removeBlur()
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [weak self] in
            self?.removeBlur()
        }
    }

    private func removeBlur() {
        self.blurView?.removeFromSuperview()
        self.blurView = nil
    }
}

extension ProfileViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return HalfHeightPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


class HalfHeightPresentationController: UIPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let height: CGFloat = 200
        return CGRect(x: 0,
                      y: containerView.bounds.height - height,
                      width: containerView.bounds.width,
                      height: height)
    }

    override func presentationTransitionWillBegin() {
        presentedView?.layer.cornerRadius = 20
        presentedView?.layer.masksToBounds = true
    }
}


extension ProfileViewController {
    
    func uploadFile(image: UIImage) {
     
        uploadfileViewModel.uploadImageFile(image: image, in: self.view) { result in
                switch result {
                case .success(let response):
                   
                    if response.status == true {
                        self.slectedImage = response.data
                       // LocalDataManager.updateUserProfileImage(response.data)
                        //MessageHelper.showBanner(message: response.message, status: .success)
                    } else {
                        MessageHelper.showBanner(message: response.message, status: .error)
                    }
                   
                case .failure(let error):
                    print(" Upload Failed:", error.localizedDescription)
                    MessageHelper.showBanner(message: "Someting Went Worng", status: .error)
                    
                }
            }
        
    }
}
