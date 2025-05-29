//
//  AboutAGDMTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 27/05/25.
//

import UIKit

class AboutAGDMTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titlebodyLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var viewDetailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        viewDetailButton.tintColor  = .white
        titleLabel.setStyledTextWithLastWordColor(fullText: "About ADGM", lastWordColor: .blueColor)
        titlebodyLabel.font  = FontManager.font(weight: .semiBold, size: 15)
        bodyLabel.font  = FontManager.font(weight: .regular, size: 14)
        viewDetailButton.titleLabel?.font  = FontManager.font(weight: .semiBold, size: 13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    
    @IBAction func viewDeatilAction(_ sender: Any) {
        
    }
    
    
    
    
}
