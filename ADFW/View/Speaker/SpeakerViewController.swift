//
//  SpeakerViewController.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import UIKit
import SwiftUI



class SpeakerViewController: UIViewController, UITextFieldDelegate, FilterSelectionDelegate {
    func didUpdateSelectedTags(_ tags: [String]) {
        print(tags)
    }
    
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var searchTexfield: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var searchView: UIView!
    
    var viewModel = SpeakerViewModel()
    var arrayOfSpeaker = [Speakers]()
    private let noDataView = NoDataView()
    
    var filteredItems: [Speakers] = []
    
    lazy var sizingCell: SpeackerCollectionViewCell = {
        let nib = UINib(nibName: "SpeackerCollectionViewCell", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! SpeackerCollectionViewCell
    }()

    
    //MARK: -- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getSpeakerData()
        collectionView.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  getSpeakerData()
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
        
        pageTitle.setStyledTextWithLastWordColor(fullText: "Our Speakers", lastWordColor: .blueColor,fontSize: 19)
        
        searchView.layer.borderColor = UIColor.lightGray.cgColor
        searchView.layer.borderWidth = 1
        
        containerView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        containerView.layer.shadowRadius = 1
        containerView.layer.masksToBounds = false
        
        searchTexfield.delegate = self
        searchTexfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        view.addSubview(noDataView)
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noDataView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDataView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noDataView.widthAnchor.constraint(equalTo: view.widthAnchor),
            noDataView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        noDataView.isHidden = true
    }
    
    
    private func showNoDataView(_ show: Bool) {
        DispatchQueue.main.async {
            self.noDataView.isHidden = !show
        }
    }
    
    
    @objc func textFieldDidChange() {
        let searchText = searchTexfield.text ?? ""
        
        if searchText.isEmpty {
            filteredItems = arrayOfSpeaker
        } else {
            filteredItems = arrayOfSpeaker.filter {
                ($0.firstName?.lowercased().contains(searchText.lowercased()) ?? false)
            }
        }
        
        collectionView.reloadData()
    }

    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func fliterButtonAction(_ sender: Any) {
        let overlay = FilterOverlayView(frame: view.bounds)
           overlay.alpha = 0
        overlay.delegate = self
           view.addSubview(overlay)

           UIView.animate(withDuration: 0.3) {
               overlay.alpha = 1
           }
    }
    
    
    
    
    
}

//MARK: -- UICollectionViewDataSource,UICollectionViewDelegate
extension SpeakerViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpeackerCollectionViewCell", for: indexPath) as! SpeackerCollectionViewCell
        
        let speaker = filteredItems[indexPath.row]
        
        cell.desigationLabel.text =  speaker.designation
        cell.nameLabel.text = (speaker.firstName ?? "") + " " + (speaker.lastName ?? "")
        cell.speakerImageView.image = nil
        if let urlString = speaker.photoURL, let url = URL(string: urlString) {
            cell.speakerImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        } else {
            cell.speakerImageView.image = UIImage(named: "")
        }
        cell.tagView.colors = [.systemTeal, .systemBlue, .systemPurple]

        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let spacing: CGFloat = 8 // Space between cells
//        let totalSpacing = spacing * 3 // left + right + between cells
//        
//        let width = (collectionView.bounds.width - totalSpacing) / 2
//        return CGSize(width: width, height: 250) // Adjust height as needed
//    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing: CGFloat = 8
        let totalSpacing = spacing * 3
        let width = (collectionView.bounds.width - totalSpacing) / 2
       // let width = collectionView.bounds.width / 2
        
        print("+====================!!!!!!+++++++++++++",collectionView.bounds.width)
        print("+====================!!!!!!+++++++++++++",width)
        
        
        let speaker = arrayOfSpeaker[indexPath.row]
        sizingCell.nameLabel.text = (speaker.firstName ?? "") + " " + (speaker.lastName ?? "")
        sizingCell.desigationLabel.text = speaker.designation

        sizingCell.bounds = CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude)
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()

        let size = sizingCell.contentView.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        )

        return CGSize(width: width, height: size.height)
    }

    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "SpeackerDetailViewController") as! SpeackerDetailViewController
        vc.speaker = filteredItems[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}






extension SpeakerViewController {
    
    
    func getSpeakerData() {
        viewModel.fetchSpeakerData(in: self.view, completion: { results in
            switch results {
            case .success(let response):
                print("data",response)
                self.showNoDataView(false)
                if let data = response.data {
                    self.arrayOfSpeaker = data
                    self.filteredItems = data
                    self.collectionView.reloadData()
                    
                }
              
            case .failure(let failure):
                self.showNoDataView(true)
                MessageHelper.showToast(message: failure.localizedDescription, in: self.view)
            }
            
            
        })
    }
}






