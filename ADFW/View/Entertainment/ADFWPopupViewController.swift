//
//  ADFWPopupViewController.swift
//  ADFW
//
//  Created by MultiTV on 02/06/25.
//


import UIKit

class ADFWPopupViewController: UIViewController {

    var dates: [String] = []
    var selectedIndex: Int = 0
    var onDateSelected: ((String, Int) -> Void)?

    private var buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setupPopup()
    }

    func setupPopup() {
        // Container view
        let container = UIView()
        container.backgroundColor = .white
       // container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: 350)
        ])

        // Title container
        let titleContainer = UIView()
        titleContainer.backgroundColor = UIColor(red: 0/255, green: 38/255, blue: 74/255, alpha: 1)
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleContainer)

        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            titleContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            titleContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            titleContainer.heightAnchor.constraint(equalToConstant: 40)
        ])

        let titleLabel = UILabel()
        titleLabel.text = "ADFW Week"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = FontManager.font(weight: .semiBold, size: 17)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor)
        ])

        // Grid stack
        let gridStack = UIStackView()
        gridStack.axis = .vertical
        gridStack.spacing = 10
        gridStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(gridStack)

        NSLayoutConstraint.activate([
            gridStack.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 16),
            gridStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            gridStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            gridStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])

        // Create 2-column grid
        let numberOfRows = Int(ceil(Double(dates.count) / 2.0))

        for row in 0..<numberOfRows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 10
            rowStack.distribution = .fillEqually

            for col in 0..<2 {
                let index = row * 2 + col
                if index < dates.count {
                    let button = UIButton(type: .system)
                    button.setTitle(dates[index], for: .normal)
                    button.titleLabel?.font = FontManager.font(weight: .semiBold, size: 17)
                    button.tag = index
                  //  button.layer.cornerRadius = 6
                    button.layer.borderWidth = 1
                    button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)

                    buttons.append(button)
                    rowStack.addArrangedSubview(button)
                } else {
                    // Add an empty view to keep layout balanced if odd number
                    let emptyView = UIView()
                    rowStack.addArrangedSubview(emptyView)
                }
            }

            gridStack.addArrangedSubview(rowStack)
        }

        updateButtonStyles()
    }

    @objc func handleButtonTap(_ sender: UIButton) {
        if selectedIndex == sender.tag {
            // If already selected, deselect
            selectedIndex = -1
            updateButtonStyles()
            onDateSelected?("", -1) // pass empty date and -1 for deselection
            dismiss(animated: true, completion: nil)
        } else {
            // Select new index
            selectedIndex = sender.tag
            updateButtonStyles()
            let selectedDate = dates[selectedIndex]
            onDateSelected?(selectedDate, selectedIndex)
            
            dismiss(animated: true, completion: nil) // Remove this line if you don't want it to dismiss immediately
        }
    }


    func updateButtonStyles() {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.backgroundColor = UIColor.blueColor
                button.setTitleColor(.white, for: .normal)
                button.layer.borderColor = UIColor.clear.cgColor
            } else {
                button.backgroundColor = .white
                button.setTitleColor(UIColor.blueColor, for: .normal)
                button.layer.borderColor = UIColor.blueColor.cgColor
            }
        }
    }
}
