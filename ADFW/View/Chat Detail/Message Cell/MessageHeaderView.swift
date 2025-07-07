//
//  MessageHeaderView.swift
//  ADFW
//
//  Created by MultiTV on 02/07/25.
//

import Foundation
import UIKit

class MessageHeaderView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        dateLabel.font = FontManager.font(weight: .medium, size: 12)
    }

    static func loadFromNib() -> MessageHeaderView {
        return Bundle.main.loadNibNamed("MessageHeaderView", owner: nil, options: nil)?.first as! MessageHeaderView
    }
}
