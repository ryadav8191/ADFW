//
//  ColorTagView.swift
//  ADFW
//
//  Created by MultiTV on 05/06/25.
//


import UIKit

class ColorTagView: UIView {

    private let circleSize: CGFloat = 15
    private let overlapSpacing: CGFloat = 5

    var colors: [UIColor] = [] {
        didSet {
            setupCircles()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        guard let view = Bundle.main.loadNibNamed("ColorTagView", owner: self, options: nil)?.first as? UIView else { return }
        view.frame = self.bounds
        view.backgroundColor = .clear
        self.addSubview(view)
    }

    private func setupCircles() {
        // Remove all subviews (except the contentView itself)
        self.subviews.dropFirst().forEach { $0.removeFromSuperview() }

        guard !colors.isEmpty else { return }

        let totalWidth = CGFloat(colors.count) * (circleSize - overlapSpacing) + overlapSpacing

        // Start drawing from the right
        var xOffset = bounds.width - totalWidth

        for color in colors {
            let circleView = UIView(frame: CGRect(x: xOffset, y: 0, width: circleSize, height: circleSize))
            circleView.backgroundColor = color
            circleView.layer.cornerRadius = circleSize / 2
            circleView.clipsToBounds = true
            addSubview(circleView)
            xOffset += (circleSize - overlapSpacing)
        }
    }

}
