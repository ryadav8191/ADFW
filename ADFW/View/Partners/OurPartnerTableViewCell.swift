//
//  OurPartnerTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 26/05/25.
//

import UIKit

class OurPartnerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupShadow(for: leftView)
        setupShadow(for: rightView)
        setupShadow(for: stackView)
        leftImageView.contentMode = .scaleAspectFit
               rightImageView.contentMode = .scaleAspectFit
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    func configure(leftImage: UIImage?, rightImage: UIImage?) {
            if let left = leftImage, let right = rightImage {
                leftImageView.image = left
                rightImageView.image = right
                leftView.isHidden = false
                rightView.isHidden = false
                stackView.alignment = .fill
                stackView.distribution = .fillEqually
            } else if let onlyImage = leftImage ?? rightImage {
                leftView.isHidden = false
                rightView.isHidden = true
                leftImageView.image = onlyImage
                stackView.alignment = .center
                stackView.distribution = .fill
            }
        }
    
    
    private func setupShadow(for view: UIView) {
        view.layer.shadowColor = UIColor(red: 0/255, green: 20/255, blue: 52/255, alpha: 0.08).cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
      //  view.layer.cornerRadius = 8
        view.backgroundColor = .white 
    }
    
    
    
}
