//
//  ScaledHeightImageView.swift
//  ADFW
//
//  Created by MultiTV on 07/06/25.
//


import UIKit

class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {
        guard let image = self.image else {
            return super.intrinsicContentSize
        }

        let imageRatio = image.size.height / image.size.width
        let width = bounds.width > 0 ? bounds.width : UIScreen.main.bounds.width
        return CGSize(width: width, height: width * imageRatio)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
}
