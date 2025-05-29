//
//  Extension.swift
//  EventApp
//
//  Created by MultiTV on 18/02/25.
//

import Foundation


import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static var lightBlue = UIColor(hex: "#002646")
    static var blueColor = UIColor(hex: "#1B6AD5")
    static var grayColor = UIColor(hex: "#6A6A6A") //#6A6A6A //#002646
}


extension UIView {
    func applyGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIImageView {
    private static var imageCache = NSCache<NSString, UIImage>()

       func loadImage(from url: URL, placeholder: UIImage? = nil) {
           // Ensure the placeholder is set on the main thread
           DispatchQueue.main.async {
               self.image = placeholder
           }

//           // Check if the image is already cached
//           if let cachedImage = UIImageView.imageCache.object(forKey: url.absoluteString as NSString) {
//               DispatchQueue.main.async {
//                   self.image = cachedImage
//               }
//               return
//           }

           // Download image from URL
           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
               guard let self = self, error == nil,
                     let data = data,
                     let image = UIImage(data: data),
                     let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                   print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                   return
               }

               // Cache the image
             //  UIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)

               // Update UI on the main thread
               DispatchQueue.main.async {
                   self.image = image
               }
           }.resume()
       }
       
    
    func loadImageWithHeightConstraint(from url: URL?, heightConstraint: NSLayoutConstraint?, completion: (() -> Void)? = nil) {
        guard let url = url else {
                 hideImageView(heightConstraint: heightConstraint, completion: completion)
                 return
             }

             self.isHidden = false
             heightConstraint?.constant = 200 // Temporary height while loading
             
             URLSession.shared.dataTask(with: url) { data, response, error in
                 if let error = error {
                     print("Failed to load image: \(error.localizedDescription)")
                     DispatchQueue.main.async {
                         self.hideImageView(heightConstraint: heightConstraint, completion: completion)
                     }
                     return
                 }

                 guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode),
                       let data = data, let image = UIImage(data: data) else {
                     print("Invalid response or failed to decode image.")
                     DispatchQueue.main.async {
                         self.hideImageView(heightConstraint: heightConstraint, completion: completion)
                     }
                     return
                 }

                 DispatchQueue.main.async {
                     self.image = image
                     self.isHidden = false
                     
                     // Calculate new height based on aspect ratio
                     let aspectRatio = image.size.height / image.size.width
                     if let imageViewWidth = self.superview?.frame.width {
                         heightConstraint?.constant = (imageViewWidth * aspectRatio) - 200
                     }
                     
                     // Force update layout
                     self.superview?.layoutIfNeeded()
                     
                     // Notify parent view to update layout
                     completion?()
                 }
             }.resume()
         }

          func hideImageView(heightConstraint: NSLayoutConstraint?, completion: (() -> Void)?) {
             self.image = nil
             self.isHidden = true
             heightConstraint?.constant = 0

             // Ensure layout updates immediately
             self.superview?.layoutIfNeeded()

             // Notify parent view to update layout
             completion?()
         }
}


extension String {
    func htmlToAttributedString(font: UIFont = UIFont.systemFont(ofSize: 16), textColor: UIColor = .black) -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            let attributedString = try NSMutableAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )

            // Apply custom font & text color
            let fullRange = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttribute(.font, value: font, range: fullRange)
            attributedString.addAttribute(.foregroundColor, value: textColor, range: fullRange)

            return attributedString
        } catch {
            print("Error converting HTML to NSAttributedString: \(error)")
            return nil
        }
    }
}

extension String {
    var decodedHTML: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html
        ]
        if let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributed.string
        }
        return self
    }
    
    var attributedFromHTML: NSAttributedString? {
           guard let data = self.data(using: .utf8) else { return nil }
           return try? NSAttributedString(
               data: data,
               options: [
                   .documentType: NSAttributedString.DocumentType.html,
                   .characterEncoding: String.Encoding.utf8.rawValue
               ],
               documentAttributes: nil
           )
       }
}


extension UILabel {
    func setStyledTextWithLastWordColor(fullText: String, lastWordColor: UIColor, fontSize: CGFloat = 19) {
        let words = fullText.components(separatedBy: " ")
        guard let lastWord = words.last else {
            self.text = fullText
            return
        }

        let attributedText = NSMutableAttributedString(string: fullText)

        let fullFont = FontManager.font(weight: .semiBold, size: fontSize)
        let lastFont = FontManager.font(weight: .bold, size: fontSize)

        attributedText.addAttribute(.font, value: fullFont, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attributedText.length))

        if let range = fullText.range(of: lastWord, options: .backwards) {
            let nsRange = NSRange(range, in: fullText)
            attributedText.addAttribute(.foregroundColor, value: lastWordColor, range: nsRange)
            attributedText.addAttribute(.font, value: lastFont, range: nsRange)
        }

        self.attributedText = attributedText
    }
}




import CoreImage

extension UIImage {
    func blurred(radius: CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: self) else { return nil }
        let context = CIContext(options: nil)

        guard let filter = CIFilter(name: "CIGaussianBlur") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(radius, forKey: kCIInputRadiusKey)

        guard let output = filter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(output, from: ciImage.extent) else { return nil }

        return UIImage(cgImage: cgImage)
    }
    
    func blurredWithBlackOverlay(radius: CGFloat, darkness: CGFloat = 0.6) -> UIImage? {
            guard let ciImage = CIImage(image: self) else { return nil }
            let context = CIContext(options: nil)

            guard let blurFilter = CIFilter(name: "CIGaussianBlur") else { return nil }
            blurFilter.setValue(ciImage, forKey: kCIInputImageKey)
            blurFilter.setValue(radius, forKey: kCIInputRadiusKey)

            guard let blurredImage = blurFilter.outputImage else { return nil }

            // Apply a black overlay
            let blackOverlay = CIFilter(name: "CIConstantColorGenerator", parameters: [
                kCIInputColorKey: CIColor(color: UIColor(white: 0, alpha: darkness))
            ])?.outputImage

            guard let overlay = blackOverlay else { return nil }

            guard let composited = CIFilter(name: "CISourceOverCompositing", parameters: [
                kCIInputImageKey: overlay,
                kCIInputBackgroundImageKey: blurredImage
            ])?.outputImage else { return nil }

            guard let cgImage = context.createCGImage(composited, from: ciImage.extent) else { return nil }

            return UIImage(cgImage: cgImage)
        }
}
