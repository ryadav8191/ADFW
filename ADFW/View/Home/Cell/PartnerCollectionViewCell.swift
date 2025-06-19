//
//  PartnerCollectionViewCell.swift
//  ADFW
//
//  Created by MultiTV on 13/06/25.
//

import UIKit

class PartnerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var partnerImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupShadow(for: containerView)

        
    }
    
    private func setupShadow(for view: UIView) {
        view.layer.shadowColor = UIColor(red: 0/255, green: 20/255, blue: 52/255, alpha: 0.1).cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 2
        view.backgroundColor = .white
    }

}
