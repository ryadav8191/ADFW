//
//  ImagePickerViewController.swift
//  ADFW
//
//  Created by MultiTV on 24/06/25.
//


import UIKit

class ImagePickerViewController: UIViewController {
    
    var cameraAction: (() -> Void)?
    var galleryAction: (() -> Void)?
    var onDismiss: (() -> Void)?
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupBlurBackground()
        setupUI()
    }
    
    private func setupBlurBackground() {
        blurView.alpha = 0.6
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.clipsToBounds = true

        // Close button
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .gray
        closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        // Title
        let titleLabel = UILabel()
        titleLabel.text = "Choose an action"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Camera and Gallery buttons
       
        
        let cameraButton = createOptionButton(title: "Camera", image: "camera", action: #selector(cameraTapped))
        let galleryButton = createOptionButton(title: "Gallery", image: "photo.on.rectangle", action: #selector(galleryTapped))


        let buttonsStack = UIStackView(arrangedSubviews: [cameraButton, galleryButton])
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .leading
        buttonsStack.spacing = 32
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(buttonsStack)

        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),

            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            buttonsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }


//    private func createOptionButton(title: String, image: String) -> UIButton {
//        let button = UIButton(type: .system)
//        button.tintColor = .systemBlue
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        let iconView = UIImageView(image: UIImage(systemName: image))
//        iconView.tintColor = .systemBlue
//        iconView.contentMode = .center
//        iconView.backgroundColor = UIColor.systemGray5
//        iconView.layer.cornerRadius = 30
//        iconView.clipsToBounds = true
//        iconView.translatesAutoresizingMaskIntoConstraints = false
//        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true
//
//        let label = UILabel()
//        label.text = title
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .systemBlue
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        let stack = UIStackView(arrangedSubviews: [iconView, label])
//        stack.axis = .vertical
//        stack.alignment = .center
//        stack.spacing = 8
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        button.addSubview(stack)
//
//        NSLayoutConstraint.activate([
//            stack.topAnchor.constraint(equalTo: button.topAnchor),
//            stack.bottomAnchor.constraint(equalTo: button.bottomAnchor),
//            stack.leadingAnchor.constraint(equalTo: button.leadingAnchor),
//            stack.trailingAnchor.constraint(equalTo: button.trailingAnchor)
//        ])
//
//        return button
//    }

    
    private func createOptionButton(title: String, image: String, action: Selector) -> UIView {
        let tapView = UIView()
        tapView.translatesAutoresizingMaskIntoConstraints = false
        tapView.isUserInteractionEnabled = true

        let iconView = UIImageView(image: UIImage(systemName: image))
        iconView.tintColor = .systemBlue
        iconView.contentMode = .center
        iconView.backgroundColor = UIColor.systemGray5
        iconView.layer.cornerRadius = 30
        iconView.clipsToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [iconView, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false

        tapView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: tapView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: tapView.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: tapView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: tapView.trailingAnchor)
        ])

        let tap = UITapGestureRecognizer(target: self, action: action)
        tapView.addGestureRecognizer(tap)

        return tapView
    }


    @objc private func cameraTapped() {
        dismiss(animated: true) {
            self.cameraAction?()
        }
    }

    @objc private func galleryTapped() {
        dismiss(animated: true) {
            self.galleryAction?()
        }
    }

    @objc private func dismissSelf() {
        dismiss(animated: true) { [weak self] in
            self?.onDismiss?()
        }
    }

}
