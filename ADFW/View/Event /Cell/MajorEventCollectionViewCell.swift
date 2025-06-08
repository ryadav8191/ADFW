//
//  MajorEventCollectionViewCell.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import UIKit

class MajorEventCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var iconImageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
    }
    
    
    func configure(with model: EventTagModel) {
        titleLabel.text = model.title

        if let icon = model.iconName {
            iconImageView.isHidden = false
          //  iconImageViewHeightConstraint.constant = 10
            iconImageView.image = UIImage(named: icon)
            iconImageView.tintColor = UIColor.init(hex: model.color)
        } else {
            iconImageView.isHidden = true
          //  iconImageViewHeightConstraint.constant = 0
        }

        if model.isButton {
            containerView.backgroundColor = UIColor.blueColor
            titleLabel.textColor = .white
            titleLabel.font = FontManager.font(weight: .semiBold, size: 12)
            containerView.layer.borderWidth = 0
        } else {
            containerView.backgroundColor = .white
            titleLabel.textColor = UIColor.lightBlue
            containerView.layer.borderWidth = 1
            titleLabel.font = FontManager.font(weight: .medium, size: 12)
            containerView.layer.borderColor =  UIColor.grayColor.cgColor
        }
    }

}
