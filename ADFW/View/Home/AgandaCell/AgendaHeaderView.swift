//
//  AgendaHeaderView.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//


import UIKit

class AgendaHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var bannerImageView: ScaledHeightImageView!
    @IBOutlet weak var imageViewHeighConstraint: NSLayoutConstraint!
    
    
    func configure(dateText: String, yearText: String, bannerImage: String?,hide:Bool) {
        dateLabel.font = FontManager.font(weight: .bold, size: 18)
        yearLabel.font = FontManager.font(weight: .semiBold, size: 16)
        dateLabel.text = dateText
        yearLabel.text = yearText
        if let image = bannerImage {
            bannerImageView.kf.setImage(
                with: URL(string: image),
                placeholder: UIImage(named: "placeholder"),
                options: [.transition(.fade(0.2))],
                completionHandler: nil
            )
        }
        
//        if hide {
//            imageViewHeighConstraint.constant = 90
//        } else {
//            imageViewHeighConstraint.constant = 0
//        }
    }
}
