//
//  AgendaHeaderView.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//


import UIKit

class AgendaHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var bannerImageView: ScaledHeightImageView!
    @IBOutlet weak var imageViewHeighConstraint: NSLayoutConstraint!
    weak var delegate: HomeSessionTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.font = FontManager.font(weight: .bold, size: 18)
        yearLabel.font = FontManager.font(weight: .semiBold, size: 16)
    }

    
    
    func configure(dateText: String, yearText: String, bannerImage: String?, hide: Bool) {
        dateLabel.text = dateText
        yearLabel.text = yearText
        
        if hide, let imageURL = bannerImage, let url = URL(string: imageURL) {
            bannerImageView.kf.setImage(
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
            bannerImageView.image = nil
        }
    }

}
