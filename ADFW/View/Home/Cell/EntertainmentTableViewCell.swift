//
//  EntertainmentTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 27/05/25.
//

import UIKit

class EntertainmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var enterainmentLabel: UILabel!
    @IBOutlet weak var entertainbodyLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var viewAllButton: UIButton!
    
    
    var onClickViewAll: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        enterainmentLabel.setStyledTextWithLastWordColor(fullText: "Entertainment @ADFW", lastWordColor: .blueColor)
        entertainbodyLabel.setStyledTextWithLastWordColor(fullText: "Entertainment @ADFW", lastWordColor: .blueColor,fontSize: 26)
        entertainbodyLabel.textColor = .white
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontManager.font(weight: .semiBold, size: 15)
        ]
        let attributedTitle = NSAttributedString(string: "View All", attributes: attributes)
        viewAllButton.setAttributedTitle(attributedTitle, for: .normal)
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func viewAllButton(_ sender: Any) {
        onClickViewAll?()
    }
    
}
