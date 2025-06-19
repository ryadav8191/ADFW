//
//  AgendaHeaderCell.swift
//  ADFW
//
//  Created by MultiTV on 16/06/25.
//

import UIKit

class AgendaHeaderCell: UITableViewCell {
    
    @IBOutlet weak var agendaImageView: ScaledHeightImageView!
    //@IBOutlet weak var titleLabel: UILabel!
    weak var delegate: HomeSessionTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(title: String, imageURL: String?) {
      //  titleLabel.text = title
        if let imageURL = imageURL, let url = URL(string: imageURL) {
            agendaImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [.transition(.fade(0.2)), .cacheOriginalImage]
            ) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let value):
                    // Notify after successful image load
                    DispatchQueue.main.async {
                        self.delegate?.homeSessionCellDidUpdateHeight()
                    }
                case .failure:
                    break
                }
            }
        } else {
            agendaImageView.image = nil
        }
    }
    
}
