//
//  DateCollectionViewCell.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateButton.layer.cornerRadius = 4
        dateButton.clipsToBounds = true
        dateButton.setTitleColor(.systemBlue, for: .normal)
        dateButton.isUserInteractionEnabled = false

    }
    
    
//    func configure(with title: String, isSelected: Bool) {
//        
//           dateButton.setTitle(title, for: .normal)
//           dateButton.backgroundColor = isSelected ? .systemBlue : .systemGray5
//           dateButton.setTitleColor(isSelected ? .white : .black, for: .normal)
//       }
    
    
    func configure(with title: String, isSelected: Bool) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontManager.font(weight: .medium, size: 15),
            .foregroundColor: isSelected ? UIColor.white : UIColor.black
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        dateButton.setAttributedTitle(attributedTitle, for: .normal)

        dateButton.backgroundColor = isSelected ? .blueColor : .systemGray5
    }


}
