//
//  FeatureEventCollectionViewCell.swift
//  ADFW
//
//  Created by MultiTV on 27/05/25.
//

import UIKit

class FeatureEventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featureImageview: ScaledHeightImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configireUI(image: String?) {
        
        if let urlString = image , let photoUrl = URL(string: urlString) {
            featureImageview.kf.setImage(with: photoUrl, placeholder: UIImage(named: ""))
        } else {
            featureImageview.image = UIImage(named: "")
        }
    }

}
