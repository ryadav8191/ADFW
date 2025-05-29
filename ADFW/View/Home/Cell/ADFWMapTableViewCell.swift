//
//  ADFWMapTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//

import UIKit
import MapKit

class ADFWMapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var mapKit: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.setStyledTextWithLastWordColor(fullText: "ADFW Map", lastWordColor: .blueColor)
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func viewAllButtonAction(_ sender: Any) {
        
        
    }
}
