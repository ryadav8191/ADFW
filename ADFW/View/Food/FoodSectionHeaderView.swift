//
//  FoodSectionHeaderView.swift
//  ADFW
//
//  Created by MultiTV on 20/06/25.
//

import UIKit


class FoodSectionHeaderView: UIView {
    
    @IBOutlet weak var sectionImageView: ScaledHeightImageView!
    @IBOutlet weak var containerView: UIView!
    weak var delegate: HomeSessionTableViewCellDelegate?
    
    
  
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradientBackground()
    }
    
    private func loadFromNib() {
        guard let view = Bundle.main.loadNibNamed("FoodSectionHeaderView", owner: self, options: nil)?.first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func configure(bannerImage: String?, hide: Bool) {
        applyGradientBackground()

        if hide, let imageURL = bannerImage, let url = URL(string: imageURL) {
            sectionImageView.kf.setImage(
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
            sectionImageView.image = nil
        }
    }

    
    private func applyGradientBackground() {
        
        containerView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(hex: "#002646").cgColor,
            UIColor(hex: "#1B6AD5").cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: cos(135.25 * .pi / 180), y: sin(135.25 * .pi / 180))
        gradient.frame = containerView.bounds
        gradient.cornerRadius = containerView.layer.cornerRadius

        containerView.layer.insertSublayer(gradient, at: 0)
    }

    
}
