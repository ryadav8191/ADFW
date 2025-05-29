//
//  AgendaNavigation&SearchView.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import Foundation


import UIKit

class AgendaNavigationSearchView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!  // Example outlet
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Load XIB and attach
        let nib = UINib(nibName: "AgendaNavigation&SearchView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
