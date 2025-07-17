//
//  GobalSpeakerTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 11/07/25.
//

import UIKit

class GobalSpeakerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filteredItems: [Speakers]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "SpeackerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpeackerCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension GobalSpeakerTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpeackerCollectionViewCell", for: indexPath) as! SpeackerCollectionViewCell
        
        let speaker = filteredItems?[indexPath.row]
        
        cell.desigationLabel.text =  speaker?.designation
        cell.nameLabel.text = (speaker?.firstName ?? "") + " " + (speaker?.lastName ?? "")
        cell.speakerImageView.image = nil
        if let urlString = speaker?.photoUrl, let url = URL(string: urlString) {
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
//        let agendaColors = getAgendaColors(for: speaker)
//           cell.tagView.colors = agendaColors

        
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

        return CGSize(width: width, height: 250)
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
//        let story = UIStoryboard(name: "Main", bundle: nil)
//        let vc = story.instantiateViewController(identifier: "SpeackerDetailViewController") as! SpeackerDetailViewController
//        vc.profile = filteredItems[indexPath.row].attributes
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}


