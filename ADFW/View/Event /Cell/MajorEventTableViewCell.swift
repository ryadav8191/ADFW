//
//  MajorEventTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import UIKit

struct EventTagModel {
    let iconName: String?    // e.g., "calendar", "clock", "location"
    let title: String
    let isButton: Bool       // for special styling (e.g., "Invite Only")
}


class MajorEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerimageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descrtion: UILabel!
    @IBOutlet weak var ViewAgendaButton: UIButton!
    @IBOutlet weak var ViewDetailButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    
    
    var tags: [EventTagModel] = [
           .init(iconName: "calendar", title: "09–12 DEC", isButton: false),
           .init(iconName: "clock", title: "8:30 - 17:00", isButton: false),
           .init(iconName: "mappin.and.ellipse", title: "Four Seasons Hotel", isButton: false),
           .init(iconName: nil, title: "Invite Only", isButton: true)
       ]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = LeftAlignedCollectionViewFlowLayout1()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "MajorEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MajorEventCollectionViewCell")
        configureUI()
        
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
 
    func configureUI () {
        selectionStyle = .none
        containerView.layer.shadowColor = UIColor(red: 0, green: 0.078, blue: 0.203, alpha: 0.1).cgColor
        containerView.layer.shadowOffset = CGSize(width: 5, height: 5)
        containerView.layer.shadowRadius = 20
        containerView.layer.shadowOpacity = 1
        containerView.layer.masksToBounds = false

        descriptionLabel.font = FontManager.font(weight: .medium, size: 13)
    }
    
    func configure(with item: AgendaSession) {
     
        descrtion.text = item.title
        collectionView.reloadData()
    }
    
}


extension MajorEventTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = tags[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MajorEventCollectionViewCell", for: indexPath) as! MajorEventCollectionViewCell
        cell.configure(with: model)
        

        return cell
    }
    
}




class LeftAlignedCollectionViewFlowLayout1: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        var leftMargin: CGFloat = sectionInset.left
        var maxY: CGFloat = -1.0

        for layoutAttribute in attributes {
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }

                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}

//extension MajorEventTableViewCell {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let tag = tags[indexPath.item]
//        let label = UILabel()
//        label.text = tag.title
//        label.font = .systemFont(ofSize: 14)
//        label.sizeToFit()
//
//        let baseWidth = label.frame.width
//        let iconWidth: CGFloat = tag.iconName != nil ? 20 : 0
//        let padding: CGFloat = 24 // Inner cell padding
//
//        return CGSize(width: baseWidth + iconWidth + padding, height: 60) // Increased height
//    }
//}
