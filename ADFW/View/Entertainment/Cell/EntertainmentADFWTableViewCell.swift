//
//  EntertainmentADFWTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 29/05/25.
//

import UIKit

class EntertainmentADFWTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addresLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        timeView.layer.borderColor = UIColor.white.cgColor
        timeView.layer.borderWidth = 1
        addressView.layer.borderColor = UIColor.white.cgColor
        addressView.layer.borderWidth = 1
        
        nameLabel.font = FontManager.font(weight: .bold, size: 17)
        descriptionLabel.font = FontManager.font(weight: .medium, size: 13.5)
        addresLabel.font = FontManager.font(weight: .medium, size: 10)
        timeLabel.font = FontManager.font(weight: .medium, size: 10)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI(_ data: Show) {
       
        if let urlString = data.image, let url = URL(string: urlString) {
            profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        } else {
          profileImageView.image = UIImage(named: "")
        }
        
        addresLabel.text = data.location?.name
        timeLabel.text = data.time
        nameLabel.text = data.name
        descriptionLabel.text = data.bio
        
        
    }
    
    
}
