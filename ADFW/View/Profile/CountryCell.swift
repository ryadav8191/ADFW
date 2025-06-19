//
//  CountryCell.swift
//  ADFW
//
//  Created by MultiTV on 18/06/25.
//

import UIKit

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var flagImageView: UIImageView!
     @IBOutlet weak var countryNameLabel: UILabel!
     @IBOutlet weak var countryCodeLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
        countryNameLabel.font = FontManager.font(weight: .semiBold, size: 14)
        
        countryCodeLabel.font = FontManager.font(weight: .semiBold, size: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with country: CountryAttributes) {
        countryNameLabel.text = country.country
        countryCodeLabel.text = "+\(country.code ?? "")"

        if let countryCode = country.flag?.lowercased() {
            let imageUrl = URL(string: "https://flagcdn.com/w40/\(countryCode).png")
            flagImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        }
    }
    
}
