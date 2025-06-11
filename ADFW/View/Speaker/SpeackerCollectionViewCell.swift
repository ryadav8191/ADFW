//
//  SpeackerCollectionViewCell.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import UIKit

class SpeackerCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desigationLabel: UILabel!
    
    @IBOutlet weak var tagView: ColorTagView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        nameLabel.font  = FontManager.font(weight: .semiBold, size: 13)
        desigationLabel.font  = FontManager.font(weight: .medium, size: 11)
        
//        nameLabel.numberOfLines = 0
//        desigationLabel.numberOfLines = 0
        
        desigationLabel.textColor = UIColor(hex: "#002646")
        nameLabel.textColor = UIColor(hex: "#002646")
        
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        speakerImageView.image = nil
//        nameLabel.text = nil
//        desigationLabel.text = nil
//    }
    
  

//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.width
//        desigationLabel.preferredMaxLayoutWidth = desigationLabel.frame.width
//    }


}
