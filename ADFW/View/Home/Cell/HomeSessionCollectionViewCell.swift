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
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var addressImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    func setupUI() {
        
        viewDetailLabel.font = FontManager.font(weight: .medium, size: 14)
        tagLabel.font = FontManager.font(weight: .medium, size: 14)
        timeLabel.font = FontManager.font(weight: .medium, size: 14)
        locationLabel.font = FontManager.font(weight: .medium, size: 14)
        titleLabel.font = FontManager.font(weight: .semiBold, size: 16)
        viewDetailsButton.layer.cornerRadius = 3
        cardContainerView.layer.shadowColor = UIColor.black.cgColor
        cardContainerView.layer.shadowOpacity = 0.1
        cardContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardContainerView.layer.shadowRadius = 4
        cardContainerView.layer.masksToBounds = false
        cardContainerView.layer.cornerRadius  = 5
        bgView.layer.cornerRadius = 3
       }
    
    func configure(with item: UpcomingSessions?) {
        self.titleLabel.text = item?.description
        self.timeLabel.text = item?.time
        self.locationLabel.text = item?.location?.data?.attributes?.name
        tagLabel.text = item?.title
        bgView.backgroundColor = UIColor(hex: item?.color ?? "")
        clockImageView.tintColor = UIColor(hex: item?.color ?? "")
        addressImageView.tintColor = UIColor(hex: item?.color ?? "")
        
        
    }
    
    

}



