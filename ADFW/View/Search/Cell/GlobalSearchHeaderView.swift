//
//  GlobalSearchHeaderView.swift
//  ADFW
//
//  Created by MultiTV on 14/07/25.
//

import Foundation


import UIKit

class GlobalSearchHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    

    // Load from XIB
    static func instantiate() -> GlobalSearchHeaderView {
            let nib = UINib(nibName: "GlobalSearchHeaderView", bundle: nil)
            let view = nib.instantiate(withOwner: nil, options: nil).first as! GlobalSearchHeaderView
            view.setupUI()
            return view
        }
    
    private func setupUI() {
        titleLabel.font = FontManager.font(weight: .semiBold, size: 19)
        titleLabel.textColor = .lightBlue
        }
}
