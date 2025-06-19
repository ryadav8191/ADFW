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
    
//    private var categories: [Category] = [
//            .init(title: "Regulation", isSelected: false),
//            .init(title: "Asset Management", isSelected: false),
//            .init(title: "Fintech", isSelected: false),
//            .init(title: "Blockchain & Ai", isSelected: true),
//            .init(title: "Economy Forum", isSelected: false),
//            .init(title: "Event - B", isSelected: false),
//            .init(title: "Setting Up In ADGM", isSelected: true),
//            .init(title: "Event - C", isSelected: false),
//            .init(title: "Event - D", isSelected: false),
//            .init(title: "Sustainable Finance", isSelected: false),
//            .init(title: "Roundtable Meeting", isSelected: false), .init(title: "Roundtable Meeting", isSelected: false), .init(title: "Roundtable Meeting", isSelected: false), .init(title: "Roundtable Meeting", isSelected: false),
//            .init(title: "Roundtable Meeting", isSelected: true)
//        ]
//    
    var viewModel = InterestViewModel()
    var arrOfInter = [InterestData]()
    
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
        
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveInterestAction(_ sender: Any) {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController") as! CustomTabBarController
            sceneDelegate.window?.rootViewController = homeVC
            sceneDelegate.window?.makeKeyAndVisible()
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       arrOfInter[indexPath.item].attributes?.is_deleted?.toggle()
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
