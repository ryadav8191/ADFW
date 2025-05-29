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
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var imageViewHeighConstraint: NSLayoutConstraint!
    
    
    func configure(dateText: String, yearText: String, bannerImage: UIImage?,hide:Bool) {
        dateLabel.font = FontManager.font(weight: .bold, size: 18)
        yearLabel.font = FontManager.font(weight: .semiBold, size: 16)
        dateLabel.text = dateText
        yearLabel.text = yearText
        bannerImageView.image = bannerImage
        
        if hide {
            imageViewHeighConstraint.constant = 90
        } else {
            imageViewHeighConstraint.constant = 0
        }
    }
}
