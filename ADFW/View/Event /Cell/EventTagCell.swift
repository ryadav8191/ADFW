//
//  EventTagCell.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import UIKit


import UIKit

class EventTagCell: UICollectionViewCell {
    static let identifier = "EventTagCell"

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let containerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        // Container View
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 6
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
        containerView.backgroundColor = .white

        // Stack View
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center

        iconImageView.setContentHuggingPriority(.required, for: .horizontal)
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true

        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .black

        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)

        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
        ])
    }

    func configure(with model: EventTagModel) {
        titleLabel.text = model.title

        if let icon = model.iconName {
            iconImageView.isHidden = false
            iconImageView.image = UIImage(systemName: icon)
        } else {
            iconImageView.isHidden = true
        }

        if model.isButton {
            containerView.backgroundColor = .systemBlue
            titleLabel.textColor = .white
            containerView.layer.borderWidth = 0
        } else {
            containerView.backgroundColor = .white
            titleLabel.textColor = .black
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor.systemGray4.cgColor
        }
    }
}
