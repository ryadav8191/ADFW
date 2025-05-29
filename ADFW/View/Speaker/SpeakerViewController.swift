//
//  SpeakerViewController.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import UIKit
import SwiftUI



class SpeakerViewController: UIViewController {
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var searchTexfield: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var searchView: UIView!
    
    
    //MARK: -- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    func configureUI() {
        self.navigationController?.navigationBar.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SpeackerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpeackerCollectionViewCell")
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//            layout.itemSize = UICollectionViewFlowLayout.automaticSize
//        }
        searchView.layer.borderColor = UIColor.lightGray.cgColor
        searchView.layer.borderWidth = 1
        
        containerView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        containerView.layer.shadowRadius = 1
        containerView.layer.masksToBounds = false
    }
    
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func fliterButtonAction(_ sender: Any) {
    }
    
    
    
    
    
}

//MARK: -- UICollectionViewDataSource,UICollectionViewDelegate
extension SpeakerViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpeackerCollectionViewCell", for: indexPath) as! SpeackerCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 8 // Space between cells
        let totalSpacing = spacing * 3 // left + right + between cells
        
        let width = (collectionView.bounds.width - totalSpacing) / 2
        return CGSize(width: width, height: 300) // Adjust height as needed
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "SpeackerDetailViewController") as! SpeackerDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}













//let profile = SpeakerProfile(
//           name: "H.E. Ahmed Jasim Al Zaabi",
//           title: "Chairman, ADGM & Abu Dhabi Dept. Of Economic Development",
//           descriptionShort: "His Excellency Ahmed Jasim Al Zaabi is member of the Abu Dhabi Executive Council...",
//           descriptionLong: "A seasoned leader with a proven track record in delivering results...",
//           imageName: "speaker_photo", // This should be in Assets.xcassets
//           tags: [
//               Tag(title: "Abu Dhabi Economic Forum", color: .blue),
//               Tag(title: "Asset Abu dhabi", color: .cyan),
//               Tag(title: "Fintech Abu dhabi", color: .red),
//               Tag(title: "R.A.C.E. Sustainability Summit", color: .gray)
//           ]
//       )
//
//       let swiftUIView = SpeakerProfileView(profile: profile) {
//           self.dismiss(animated: true, completion: nil)
//       }
//
//       let hostingController = UIHostingController(rootView: swiftUIView)
//       addChild(hostingController)
//       hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//       view.addSubview(hostingController.view)
//       NSLayoutConstraint.activate([
//           hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
//           hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//           hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//           hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//       ])
//       hostingController.didMove(toParent: self)
//   }
