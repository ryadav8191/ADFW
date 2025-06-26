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
    @IBOutlet weak var restaurantLogo: UIImageView!
    @IBOutlet weak var viewAllLabel: UILabel!
    
    var viewMenu: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        confiqureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
        
        restaurantLogo.layer.borderWidth = 0.5
        restaurantLogo.layer.borderColor = UIColor.lightBlue.cgColor
    }
    
    func configureData(restaurant: Restaurants?) {
        if let data = restaurant {
            if let urlString = data.restaurant_logo , let photoUrl = URL(string: urlString) {
                restaurantLogo.kf.setImage(with: photoUrl, placeholder: UIImage(named: ""))
            } else {
                restaurantLogo.image = UIImage(named: "")
            }
            
            foodLabel.text = data.restaurant_description
        } else {
            
        }
        
       
       
        
    }
    
    
    @IBAction func viewAllAction(_ sender: Any) {
        viewMenu?()
    }
    
    
    
}
