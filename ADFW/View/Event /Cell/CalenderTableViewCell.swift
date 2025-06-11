//
//  CalenderTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import UIKit

class CalenderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressImgview: UIImageView!
    
    
    @IBOutlet weak var bgColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        titleLabel.font = FontManager.font(weight: .semiBold, size: 17.5)
        addressLabel.font = FontManager.font(weight: .regular, size: 12.5)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    func configureData(with item: Agendas?) {
        self.titleLabel.text = item?.title
        self.addressLabel.text = item?.location?.name
        self.bgColor.backgroundColor = UIColor(hex: item?.color ?? "")
    }
    
}
