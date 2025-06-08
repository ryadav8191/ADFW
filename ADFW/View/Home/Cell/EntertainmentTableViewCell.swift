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
    
    var onClickViewAll: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        enterainmentLabel.setStyledTextWithLastWordColor(fullText: "Entertainment @ADFW", lastWordColor: .blueColor)
        entertainbodyLabel.setStyledTextWithLastWordColor(fullText: "Entertainment @ADFW", lastWordColor: .blueColor,fontSize: 26)
        entertainbodyLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func viewAllButton(_ sender: Any) {
        onClickViewAll?()
    }
    
}
