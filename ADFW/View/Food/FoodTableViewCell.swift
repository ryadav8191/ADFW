//
//  FoodTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodViewImageView: UIImageView!
    
    @IBOutlet weak var viewAllLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        confiqureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func confiqureUI() {
        containerView.layer.shadowColor = UIColor(red: 20/255, green: 52/255, blue: 20/255, alpha: 0.08).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 5, height: 5)
        containerView.layer.shadowRadius = 20
        containerView.layer.masksToBounds = false

        foodLabel.font = FontManager.font(weight: .medium, size: 14)
        
        viewAllLabel.font = FontManager.font(weight: .medium, size: 14)
        
        foodLabel.textColor = .lightBlue
    }
    
    
    @IBAction func viewAllAction(_ sender: Any) {
        
    }
    
    
    
}
