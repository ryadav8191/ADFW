//
//  HomeSessionCollectionViewCell.swift
//  ADFW
//
//  Created by MultiTV on 27/05/25.
//

import UIKit
import CollectionViewPagingLayout

class HomeSessionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var viewDetailsButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     setupUI()
    }
    
    
    func setupUI() {
        
        
        viewDetailsButton.titleLabel?.font = FontManager.font(weight: .medium, size: 14)
        tagButton.titleLabel?.font = FontManager.font(weight: .medium, size: 14)
        timeLabel.font = FontManager.font(weight: .medium, size: 13)
        locationLabel.font = FontManager.font(weight: .medium, size: 13)
        titleLabel.font = FontManager.font(weight: .semiBold, size: 16)
        viewDetailsButton.layer.cornerRadius = 3
        
        
        
        cardContainerView.layer.shadowColor = UIColor.black.cgColor
        cardContainerView.layer.shadowOpacity = 0.1
        cardContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardContainerView.layer.shadowRadius = 4
        cardContainerView.layer.masksToBounds = false
        cardContainerView.layer.cornerRadius  = 5
       }
    
    func configure(with item: String) {
            // Configure your UI with data (label/image etc.)
        }
    
    

}


//// MARK: - Transform Effects
//extension HomeSessionCollectionViewCell: ScaleTransformView {
//    var scalableView: UIView {
//        return cardContainerView
//    }
//
//    var scaleOptions: ScaleTransformViewOptions {
//        return .layout(.linear)
//    }
//}
//
//extension HomeSessionCollectionViewCell: TransformableView {
//    var selectableView: UIView? {
//        return cardContainerView
//    }
//
//    func transform(progress: CGFloat) {
//        let scale = 1 - abs(progress) * 0.1
//        cardContainerView.transform = CGAffineTransform(scaleX: scale, y: scale)
//        cardContainerView.alpha = 1 - abs(progress) * 0.3
//    }
//}
