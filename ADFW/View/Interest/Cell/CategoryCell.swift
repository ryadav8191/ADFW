//
//  CategoryCell.swift
//  ADFW
//
//  Created by MultiTV on 25/05/25.
//

import UIKit



class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontManager.font(weight: .medium, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ?  UIColor.blueColor : .white
            titleLabel.textColor = isSelected ? .white : UIColor.blueColor
            contentView.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
    contentView.layer.cornerRadius = 4
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.backgroundColor = .white

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }

   
    
    func configure(with category: Category) {
        titleLabel.text = category.title
        contentView.backgroundColor = category.isSelected ?UIColor.blueColor : .white
        titleLabel.textColor = category.isSelected ? .white : UIColor.blueColor
        contentView.layer.borderColor = UIColor.blueColor.cgColor
    }

}
