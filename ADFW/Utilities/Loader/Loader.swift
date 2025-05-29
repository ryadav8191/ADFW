//
//  Loader.swift
//  EventApp
//
//  Created by MultiTV on 12/02/25.
//


import UIKit


class Loader {
    static let shared = Loader()

    private var activityIndicator: UIActivityIndicatorView?
    private var overlayView: UIView?
    private var indicatorBackgroundView: UIView?

    private init() {}

    func show(in view: UIView) {
        // Create an overlay to block interaction
        if overlayView == nil {
            let overlay = UIView(frame: view.bounds)
            overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            overlay.isUserInteractionEnabled = true
            view.addSubview(overlay)
            overlayView = overlay
        }

        // Create white background behind the indicator
        if indicatorBackgroundView == nil {
            let bgView = UIView()
            bgView.backgroundColor = .white.withAlphaComponent(0.8)
            bgView.layer.cornerRadius = 10
            bgView.clipsToBounds = true
            bgView.translatesAutoresizingMaskIntoConstraints = false
            overlayView?.addSubview(bgView)
            indicatorBackgroundView = bgView

            NSLayoutConstraint.activate([
                bgView.centerXAnchor.constraint(equalTo: overlayView!.centerXAnchor),
                bgView.centerYAnchor.constraint(equalTo: overlayView!.centerYAnchor),
                bgView.widthAnchor.constraint(equalToConstant: 80),
                bgView.heightAnchor.constraint(equalToConstant: 80)
            ])
        }

        // Create and start activity indicator
        if activityIndicator == nil {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .gray
            indicator.hidesWhenStopped = true
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicatorBackgroundView?.addSubview(indicator)
            activityIndicator = indicator

            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: indicatorBackgroundView!.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: indicatorBackgroundView!.centerYAnchor)
            ])
        }

        overlayView?.isHidden = false
        indicatorBackgroundView?.isHidden = false
        activityIndicator?.startAnimating()
    }

    func hide() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        indicatorBackgroundView?.removeFromSuperview()
        overlayView?.removeFromSuperview()

        activityIndicator = nil
        indicatorBackgroundView = nil
        overlayView = nil
    }
}
