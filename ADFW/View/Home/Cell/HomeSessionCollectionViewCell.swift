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
    @IBOutlet weak var viewDetailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
        locationLabel.text = "Changing the background color of UITableViewHeaderFooterView is not supported. Use the background view configuration instead."
        timeLabel.text = "Changing the background color of UITableViewHeaderFooterView is not supported. Use the background view configuration instead."
    }
    
    
    func setupUI() {
        
        viewDetailLabel.font = FontManager.font(weight: .medium, size: 14)
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
        
        
        
    }
    
    

}



