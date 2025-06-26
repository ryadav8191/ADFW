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
    
    var onClickViewAll: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        viewDetailButton.tintColor  = .white
        titleLabel.setStyledTextWithLastWordColor(fullText: "About ADGM", lastWordColor: .blueColor)
        titlebodyLabel.font  = FontManager.font(weight: .semiBold, size: 15)
        bodyLabel.font  = FontManager.font(weight: .regular, size: 14)
      
       
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontManager.font(weight: .semiBold, size: 15)
        ]
        let attributedTitle = NSAttributedString(string: "View Details", attributes: attributes)
        viewDetailButton.setAttributedTitle(attributedTitle, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    
    @IBAction func viewDeatilAction(_ sender: Any) {
        onClickViewAll?()
    }
    
    
    
    
}
