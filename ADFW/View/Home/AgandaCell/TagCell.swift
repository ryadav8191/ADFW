//
//  TagCell.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import UIKit


class TagCell: UICollectionViewCell {
    static let identifier = "TagCell"

    private let dotView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.font(weight: .medium, size: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E8F0FF") // Light blue
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(dotView)
        containerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            dotView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            dotView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            dotView.widthAnchor.constraint(equalToConstant: 10),
            dotView.heightAnchor.constraint(equalToConstant: 10),

            titleLabel.leadingAnchor.constraint(equalTo: dotView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }

    func configure(data: AgandaFilter?, isSelected: Bool = false) {
        titleLabel.text = data?.title
        dotView.backgroundColor = isSelected ? .black : .systemBlue
        containerView.backgroundColor = isSelected
            ? UIColor(red: 0.85, green: 0.92, blue: 1.0, alpha: 1)
            : UIColor(red: 0.9, green: 0.95, blue: 1.0, alpha: 1)
    }
}
