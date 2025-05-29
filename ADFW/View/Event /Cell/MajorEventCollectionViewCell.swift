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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.font = FontManager.font(weight: .medium, size: 12)
    }
    
    
    func configure(with model: EventTagModel) {
        titleLabel.text = model.title

        if let icon = model.iconName {
            iconImageView.isHidden = false
            iconImageView.image = UIImage(systemName: icon)
        } else {
            iconImageView.isHidden = true
        }

        if model.isButton {
            containerView.backgroundColor = UIColor.blueColor
            titleLabel.textColor = .white
            containerView.layer.borderWidth = 0
        } else {
            containerView.backgroundColor = .white
            titleLabel.textColor = UIColor.lightBlue
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor =  UIColor.grayColor.cgColor
        }
    }

}
