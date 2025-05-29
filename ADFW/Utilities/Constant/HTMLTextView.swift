//
//  HTMLTextView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//


import SwiftUI
import UIKit

struct HTMLTextView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        guard let data = html.data(using: .utf8) else {
            uiView.text = html
            return
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            uiView.attributedText = attributedString
        } else {
            uiView.text = html
        }
    }
}
