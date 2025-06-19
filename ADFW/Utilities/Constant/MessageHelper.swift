//
//  MessageHelper.swift
//  MSVC2025
//
//  Created by MultiTV on 05/04/25.
//

import UIKit


class MessageHelper {
    static func showAlert(message: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
    
    static func showAlertWithClouser(message: String, on viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        viewController.present(alert, animated: true)
    }

    static func showToast(message: String, in view: UIView) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textAlignment = .center
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        let textSize = toastLabel.sizeThatFits(CGSize(width: view.frame.width - 40, height: CGFloat.greatestFiniteMagnitude))
        toastLabel.frame = CGRect(x: 20, y: view.frame.height - 100, width: view.frame.width - 40, height: textSize.height + 20)

        view.addSubview(toastLabel)

        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
    
    
    static func showBanner(message: String, status: BannerStatus, duration: TimeInterval = 2.0) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

        let bannerHeight: CGFloat = 70
        let safeTop = window.safeAreaInsets.top

        let bannerView = UIView(frame: CGRect(x: 0, y: -bannerHeight, width: window.frame.width, height: bannerHeight))
        
        // Set background color based on status
        switch status {
        case .success:
            bannerView.backgroundColor = UIColor.systemGreen
        case .error:
            bannerView.backgroundColor = UIColor.systemRed
        }

        // Shadow
        bannerView.layer.shadowColor = UIColor.black.cgColor
        bannerView.layer.shadowOpacity = 0.25
        bannerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bannerView.layer.shadowRadius = 4
        bannerView.layer.masksToBounds = false

        // Icon
        let iconName: String
        let iconTint: UIColor
        switch status {
        case .success:
            iconName = "tick"
            iconTint = .systemGreen
        case .error:
            iconName = "delete"
            iconTint = .systemRed
        }

        let imageView = UIImageView(image: UIImage(named: iconName))
      //  imageView.tintColor = iconTint
     
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true

        switch status {
        case .success:
          
            imageView.backgroundColor = .white
        case .error:
          
            imageView.backgroundColor = .white
        }
        
        
        // Label
        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.font = FontManager.font(weight: .semiBold, size: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        // StackView
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        bannerView.addSubview(stackView)
        window.addSubview(bannerView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: bannerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
        ])

        UIView.animate(withDuration: 0.4) {
            bannerView.frame.origin.y = safeTop
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                UIView.animate(withDuration: 0.4, animations: {
                    bannerView.frame.origin.y = -bannerHeight
                }) { _ in
                    bannerView.removeFromSuperview()
                }
            }
        }
    }

}
