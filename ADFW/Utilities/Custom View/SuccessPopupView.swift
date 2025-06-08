//
//  SuccessPopupView.swift
//  ADFW
//
//  Created by MultiTV on 29/05/25.
//


import UIKit

class SuccessPopupView: UIView {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill") // or your custom check image
        imageView.tintColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Successful"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "You are signed out from account"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6

        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(messageLabel)

        horizontalStack.addArrangedSubview(iconImageView)
        horizontalStack.addArrangedSubview(contentStack)

        addSubview(horizontalStack)

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),

            horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
