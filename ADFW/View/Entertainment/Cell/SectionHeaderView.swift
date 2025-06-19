//
//  SectionHeaderView.swift
//  ADFW
//
//  Created by MultiTV on 30/05/25.
//


import UIKit

import UIKit

class SectionHeaderView: UIView {
    
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerBodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var ContainerViewHeightConstraints: NSLayoutConstraint!
    
    private var gradientLayer: CAGradientLayer?
    
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
        DispatchQueue.main.async {
            if self.gradientLayer == nil {
                self.addAndroidStyleGradient()
            }
              self.gradientLayer?.frame = self.headerImageView.bounds
          }
    }
    
    private func addAndroidStyleGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.0).cgColor,
            UIColor.black.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        headerImageView.layer.addSublayer(gradient)
        self.gradientLayer = gradient
    }


    private func loadFromNib() {
        guard let view = Bundle.main.loadNibNamed("SectionHeaderView", owner: self, options: nil)?.first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func configure(dateText: String, dayText: String, showHeaderView: Bool, height: CGFloat, image: String?) {
        let fullText = "\(Helper.formatToDayMonth(from: dateText)?.capitalized ?? "") – \(dayText.capitalized)"
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: dateText.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemPink, range: NSRange(location: fullText.count - dayText.count, length: dayText.count))
        titleLabel.attributedText = attributedString
        titleLabel.font = FontManager.font(weight: .semiBold, size: 20)
        
        headerTitleLabel.font = FontManager.font(weight: .semiBold, size: 26)
        headerBodyLabel.font = FontManager.font(weight: .medium, size: 14)
        
        
        if let urlString = image , let photoUrl = URL(string: urlString) {
            headerImageView.kf.setImage(with: photoUrl, placeholder: UIImage(named: "header_background"))
        } else {
            headerImageView.image = UIImage(named: "header_background")
        }
        

        if showHeaderView {
            containerView.isHidden = true
            ContainerViewHeightConstraints.constant = 0
        } else {
            containerView.isHidden = false
            ContainerViewHeightConstraints.constant = height
        }
    }
}
