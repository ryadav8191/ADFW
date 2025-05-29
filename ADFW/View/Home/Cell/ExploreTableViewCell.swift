//
//  ExploreTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 27/05/25.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var downloadImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        downloadLabel.font = FontManager.font(weight: .medium, size: 13)
        downloadLabel.textColor = .blueColor
        titleLabel.setStyledTextWithLastWordColor(fullText: "Explore Abu Dhabi", lastWordColor: .blueColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        
    }
}
