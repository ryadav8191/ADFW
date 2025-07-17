//
//  InterestViewController.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//

import UIKit


struct Category {
    let title: String
    var isSelected: Bool
}

enum InterestType {
    case HomeInterest
    case LoginInterest
}


class InterestViewController: UIViewController {
    
    @IBOutlet weak var pageHeaderLabel: UILabel!
    @IBOutlet weak var cateLabel: UILabel!
    @IBOutlet weak var cateBodyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var openToNetLabel: UILabel!
    @IBOutlet weak var categorieView: UIView!
    @IBOutlet weak var openToNetWorkView: UIView!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainHeaderContainer: UIView!
    @IBOutlet weak var navigationBarView: UIView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var navigationTitle: UILabel!
    

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    
    var viewModel = InterestViewModel()
    var arrOfInter = [InterestData]()
    var pageType:InterestType = .HomeInterest
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        scrollView.contentInsetAdjustmentBehavior = .never
        getInterest()

    }
    
    func updateCollectionViewHeight() {
        collectionView.layoutIfNeeded()
        collectionHeightConstraint.constant = collectionView.contentSize.height
    }
    
    
    
    func configureUI() {
        categorieView.layer.shadowColor = UIColor(red: 20/255, green: 52/255, blue: 20/255, alpha: 0.08).cgColor
        categorieView.layer.shadowOpacity = 1
        categorieView.layer.shadowOffset = CGSize(width: 5, height: 5)
        categorieView.layer.shadowRadius = 20
        categorieView.layer.masksToBounds = false
        
        
        openToNetWorkView.layer.shadowColor = UIColor(red: 20/255, green: 52/255, blue: 20/255, alpha: 0.08).cgColor
        openToNetWorkView.layer.shadowOpacity = 1
        openToNetWorkView.layer.shadowOffset = CGSize(width: 5, height: 5)
        openToNetWorkView.layer.shadowRadius = 20
        openToNetWorkView.layer.masksToBounds = false
        
        
        collectionView.allowsMultipleSelection = true

        let layout = LeftAlignedCollectionViewFlowLayout()
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        updateCollectionViewHeight()
        
        
        cateLabel.font = FontManager.font(weight: .semiBold, size: 16)
        cateLabel.textColor = UIColor.blueColor
        cateBodyLabel.font = FontManager.font(weight: .medium, size: 14)
        cateBodyLabel.textColor = UIColor.grayColor
        messageLabel.font = FontManager.font(weight: .semiBold, size: 16)
        messageLabel.textColor = UIColor.blueColor
        openToNetLabel.font = FontManager.font(weight: .semiBold, size: 16)
        openToNetLabel.textColor = UIColor.grayColor
        
        pageHeaderLabel.font = FontManager.font(weight: .semiBold, size: 26)
       // pageHeaderLabel.textColor = UIColor.blueColor
        
        switch pageType {
        case .HomeInterest:
            
            mainHeaderContainer.backgroundColor = .white
            pageTitle.text = ""
            backgroundImageView.isHidden = true
            navigationBarView.isHidden = false
            navigationTitle.font = FontManager.font(weight: .semiBold, size: 19)
            mainHeaderContainer.applyBoxShadow()
            
        case .LoginInterest:
            mainHeaderContainer.backgroundColor = .clear
            pageTitle.text = "WELCOME TO THE\nCAPITAL OF CAPITAL"
            backgroundImageView.isHidden = false
            navigationBarView.isHidden = true
        }
        
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveInterestAction(_ sender: Any) {
        
        viewModel.saveInterests(ticketId: LocalDataManager.getUserId(), interests: LocalDataManager.getSelectedInterests(), in: self.view) { result in
            switch result {
            case .success(let message):
                print("✅ Saved:", message)
                if self.pageType != .HomeInterest {
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let homeVC = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController") as! CustomTabBarController
                        sceneDelegate.window?.rootViewController = homeVC
                        sceneDelegate.window?.makeKeyAndVisible()
                    }
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
                MessageHelper.showBanner(message: message, status: .success)
            case .failure(let error):
                print("❌ Error:", error.localizedDescription)
                MessageHelper.showBanner(message: error.localizedDescription, status: .error)
            }
        }
    }
}



extension InterestViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfInter.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: arrOfInter[indexPath.item])
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//       arrOfInter[indexPath.item].attributes?.is_deleted?.toggle()
//        UIView.performWithoutAnimation {
//            collectionView.reloadItems(at: [indexPath])
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedInterest = arrOfInter[indexPath.item].attributes else { return }

        var savedValues = LocalDataManager.getSelectedInterests()

        if let index = savedValues.firstIndex(where: { $0.value == selectedInterest.value }) {
            // Unselect
            savedValues.remove(at: index)
        } else {
            // Select
            savedValues.append(UserInterestData.init(label: selectedInterest.label ?? "", value: selectedInterest.value ?? ""))
        }

        // Save updated selection to UserDefaults
        LocalDataManager.saveSelectedInterests(savedValues)

        UIView.performWithoutAnimation {
            collectionView.reloadItems(at: [indexPath])
        }
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = arrOfInter[indexPath.item].attributes?.label ?? ""
        let size = (text as NSString).size(withAttributes: [.font: FontManager.font(weight: .medium, size: 14)])
        return CGSize(width: size.width + 35, height: 36)
    }
}


extension InterestViewController {
    
    func getInterest() {
        
        viewModel.fetchInterests(in: self.view) { result in
            switch result {
            case .success(let interests):
                print("Fetched interests: \(interests)")
                self.arrOfInter = interests
                self.getUserInterest()
            case .failure(let error):
                MessageHelper.showAlert(message: error.localizedDescription, on: self)
            }
        }
    }
    
    func getUserInterest() {
        viewModel.fetchInterestById(id: LocalDataManager.getUserId(), in: self.view) { result in
            switch result {
            case .success(let userInterests):
               // let selectedValues = userInterests
                              //  .compactMap { $0.value }
                LocalDataManager.saveSelectedInterests(userInterests)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.updateCollectionViewHeight()
                }
                
            case .failure(let error):
                MessageHelper.showAlert(message: error.localizedDescription, on: self)
            }
        }
    }
}


