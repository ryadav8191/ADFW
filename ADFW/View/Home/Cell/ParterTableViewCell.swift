//
//  ParterTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 27/05/25.
//

import UIKit

class ParterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var partnerLgo: UIImageView!
    
    
    @IBOutlet weak var headLineLabel: UILabel!
    
    var onClickViewAll: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        titleLabel.setStyledTextWithLastWordColor(fullText: "Our Partners", lastWordColor: .blueColor)
        headLineLabel.font = FontManager.font(weight: .semiBold, size: 18)
        headLineLabel.textColor = .blueColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    @IBAction func viewAllAction(_ sender: Any) {
        onClickViewAll?()
    }
    
    
    
    
}
