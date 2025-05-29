//
//  CategoryPopupView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import UIKit


import UIKit

class CategoryPopupView: UIView {

    var onFoodTap: (() -> Void)?
    var onEntertainmentTap: (() -> Void)?

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
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        translatesAutoresizingMaskIntoConstraints = false

        // FOOD
        let foodIcon = UIImageView(image: UIImage(systemName: "takeoutbag.and.cup.and.straw"))
        foodIcon.tintColor = .systemBlue
        foodIcon.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let foodLabel = UILabel()
        foodLabel.text = "Food @ ADFW"
        foodLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        foodLabel.textColor = .black

        let foodStack = UIStackView(arrangedSubviews: [foodIcon, foodLabel])
        foodStack.axis = .horizontal
        foodStack.spacing = 8
        foodStack.alignment = .center
        foodStack.translatesAutoresizingMaskIntoConstraints = false
        foodStack.isUserInteractionEnabled = false

        let foodButton = UIButton()
        foodButton.layer.cornerRadius = 8
       // foodButton.backgroundColor = .systemGray6
        foodButton.addTarget(self, action: #selector(foodTapped), for: .touchUpInside)
        foodButton.translatesAutoresizingMaskIntoConstraints = false
        foodButton.addSubview(foodStack)

        NSLayoutConstraint.activate([
            foodStack.centerYAnchor.constraint(equalTo: foodButton.centerYAnchor),
            foodStack.centerXAnchor.constraint(equalTo: foodButton.centerXAnchor),
            foodButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        // ENTERTAINMENT
        let entertainmentIcon = UIImageView(image: UIImage(systemName: "sparkles"))
        entertainmentIcon.tintColor = .systemBlue
        entertainmentIcon.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let entertainmentLabel = UILabel()
        entertainmentLabel.text = "Entertainments"
        entertainmentLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        entertainmentLabel.textColor = .black

        let entertainmentStack = UIStackView(arrangedSubviews: [entertainmentIcon, entertainmentLabel])
        entertainmentStack.axis = .horizontal
        entertainmentStack.spacing = 8
        entertainmentStack.alignment = .center
        entertainmentStack.translatesAutoresizingMaskIntoConstraints = false
        entertainmentStack.isUserInteractionEnabled = false

        let entertainmentButton = UIButton()
        entertainmentButton.layer.cornerRadius = 8
       // entertainmentButton.backgroundColor = .systemGray6
        entertainmentButton.addTarget(self, action: #selector(entertainmentTapped), for: .touchUpInside)
        entertainmentButton.translatesAutoresizingMaskIntoConstraints = false
        entertainmentButton.addSubview(entertainmentStack)

        NSLayoutConstraint.activate([
            entertainmentStack.centerYAnchor.constraint(equalTo: entertainmentButton.centerYAnchor),
            entertainmentStack.centerXAnchor.constraint(equalTo: entertainmentButton.centerXAnchor),
            entertainmentButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        // Main stack
        let mainStack = UIStackView(arrangedSubviews: [foodButton, entertainmentButton])
        mainStack.axis = .horizontal
        mainStack.spacing = 20
        mainStack.distribution = .fillEqually
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.heightAnchor.constraint(equalToConstant: 90)
        ])
    }

    @objc private func foodTapped() {
        onFoodTap?()
        self.removeFromSuperview()
    }

    @objc private func entertainmentTapped() {
        onEntertainmentTap?()
        self.removeFromSuperview()
    }
}
