//
//  NoDataView.swift
//  EventApp
//
//  Created by MultiTV on 19/02/25.
//

import UIKit

class NoDataView: UIView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data Available"
        label.textAlignment = .center
        label.textColor = .blueColor
        label.font = FontManager.font(weight: .bold, size: 18)
        label.isHidden = false
        return label
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear  // Transparent background
        isUserInteractionEnabled = false // Allow touches to pass through
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        setupView()
    }
    
    private func setupView() {
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Show/Hide Method
    func setMessage(_ message: String) {
        messageLabel.text = message
    }
}


class SnackbarView: UIView {
    private let label = UILabel()

    init(message: String) {
        super.init(frame: CGRect(x: 20, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width - 40, height: 50))
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        layer.cornerRadius = 10

        label.text = message
        label.textColor = .white
        label.textAlignment = .center
        label.frame = bounds

        addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(in view: UIView) {
        view.addSubview(self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.removeFromSuperview()
        }
    }
}
