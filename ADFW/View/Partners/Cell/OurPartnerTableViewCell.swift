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
    
    @IBOutlet weak var leftSpacer: UIView!
    @IBOutlet weak var rightSpacer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupShadow(for: leftView)
        setupShadow(for: rightView)
        //setupShadow(for: stackView)
        leftImageView.contentMode = .scaleAspectFit
               rightImageView.contentMode = .scaleAspectFit
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
//    
//    func configure(leftImage: UIImage?, rightImage: UIImage?) {
//            if let left = leftImage, let right = rightImage {
//                leftImageView.image = left
//                rightImageView.image = right
//                leftView.isHidden = false
//                rightView.isHidden = false
//                stackView.alignment = .fill
//                stackView.distribution = .fillEqually
//            } else if let onlyImage = leftImage ?? rightImage {
//                leftView.isHidden = false
//                rightView.isHidden = true
//                leftImageView.image = onlyImage
//                stackView.alignment = .center
//                stackView.distribution = .fill
//                setupShadow(for: stackView)
//            }
//        }
//    
    
//    
//    func configure(leftImageURL: String?, rightImageURL: String?) {
//        if let leftURLString = leftImageURL, let rightURLString = rightImageURL,
//           let leftURL = URL(string: leftURLString), let rightURL = URL(string: rightURLString) {
//
//            leftImageView.kf.setImage(with: leftURL, placeholder: UIImage(named: "placeholder"))
//            rightImageView.kf.setImage(with: rightURL, placeholder: UIImage(named: "placeholder"))
//
//            leftView.isHidden = false
//            rightView.isHidden = false
//            stackView.alignment = .fill
//            stackView.distribution = .fillEqually
//
//        } else if let onlyURLString = leftImageURL ?? rightImageURL,
//                  let url = URL(string: onlyURLString) {
//
//            leftImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
//            leftView.isHidden = false
//            rightView.isHidden = true
//            stackView.alignment = .center
//            stackView.distribution = .fill
//            setupShadow(for: leftView)
//            
//        } else {
//            // Both URLs are invalid or nil
//            leftImageView.image = UIImage(named: "person1")
//            rightImageView.image = nil
//            leftView.isHidden = false
//            rightView.isHidden = true
//        }
//    }

    
    


    
    func configure(leftImageURL: String?, rightImageURL: String?) {
        if let leftURLString = leftImageURL,
           let rightURLString = rightImageURL,
           let leftURL = URL(string: leftURLString),
           let rightURL = URL(string: rightURLString) {

            // Two logos
            leftImageView.kf.setImage(with: leftURL, placeholder: UIImage(named: "placeholder"))
            rightImageView.kf.setImage(with: rightURL, placeholder: UIImage(named: "placeholder"))

            leftView.isHidden = false
            rightView.isHidden = false
            leftSpacer.isHidden = true
            rightSpacer.isHidden = true

        } else if let onlyURLString = leftImageURL ?? rightImageURL,
                  let url = URL(string: onlyURLString) {

            // One logo, centered
            leftImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            leftView.isHidden = false
            rightView.isHidden = true
            leftSpacer.isHidden = false
            rightSpacer.isHidden = false

        } else {
            // No valid logo
            leftImageView.image = UIImage(named: "placeholder")
            leftView.isHidden = false
            rightView.isHidden = true
            leftSpacer.isHidden = false
            rightSpacer.isHidden = false
        }
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
