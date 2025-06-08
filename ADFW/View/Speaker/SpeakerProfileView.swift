//
//  SpeakerProfileView.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//





import SwiftUI

import SwiftUI
import Kingfisher
import WebKit

struct SpeakerProfileView: View {
    let profile: Speakers
    var onClose: (() -> Void)? = nil
    @State private var size: CGSize = .zero

    var htmlFormattedBio: String {
        """
        <html>
        <head>
            <style>
                body {
                    margin: 0;
                    padding: 0;
                       font-family: 'IsidoraSans-Regular';
                    font-size: 14px;
                    color: #0D0D0D;
                }
            </style>
        </head>
        <body>
        \(profile.bio ?? "")
        </body>
        </html>
        """
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Close button
                HStack {
                    Spacer()
                    Button(action: {
                        onClose?()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }

                // Profile image and name/title
                HStack(alignment: .center, spacing: 12) {
                    KFImage(URL(string: profile.photoURL ?? ""))
                        .resizable()
                        .frame(width: 105, height: 115)
                        .clipShape(RoundedRectangle(cornerRadius: 0))

                    VStack(alignment: .leading, spacing: 4) {
                        Text((profile.firstName ?? "") + " " + (profile.lastName ?? ""))
                            .font(Font(FontManager.font(weight: .bold, size: 18)))
                            .foregroundColor(Color(UIColor.lightBlue))

                        Text(profile.designation ?? "")
                            .font(Font(FontManager.font(weight: .regular, size: 12)))
                            .foregroundColor(Color(UIColor(hex: "#555555")))
                    }
                }

                // Bio with dynamic HTML height
                AttributedText(htmlContent: htmlFormattedBio, size: $size)
                    .frame(height: size.height)

                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(0)
        .padding(.horizontal)
    }
}



struct TagView: View {
    var text: String
    var color: Color

    var body: some View {
        HStack(spacing: 8.0) {
            Circle()
                .fill(color) // Use .fill to apply the color
                .frame(width: 12, height: 12)

            Text(text)
                .font(Font(FontManager.font(weight: .medium, size: 11.83)))
                .foregroundColor(Color(UIColor.lightBlue))
               // .foregroundColor(.black)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .stroke(color, lineWidth: 1)
        )
    }
}



import SwiftUI
import Kingfisher

func layout(sizes: [CGSize],
            spacing: CGFloat = 8,
            containerWidth: CGFloat) -> (offsets: [CGPoint], size: CGSize) {
    var result: [CGPoint] = []
    var currentPosition: CGPoint = .zero
    var lineHeight: CGFloat = 0
    var maxX: CGFloat = 0

    for size in sizes {
        if currentPosition.x + size.width > containerWidth {
            currentPosition.x = 0
            currentPosition.y += lineHeight + spacing
            lineHeight = 0
        }
        result.append(currentPosition)
        currentPosition.x += size.width + spacing
        maxX = max(maxX, currentPosition.x)
        lineHeight = max(lineHeight, size.height)
    }

    return (result, CGSize(width: maxX, height: currentPosition.y + lineHeight))
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    @available(iOS 16.0, *)
    func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews,
                      cache: inout ()) -> CGSize {
        let containerWidth = proposal.width ?? .infinity
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return layout(sizes: sizes, spacing: spacing, containerWidth: containerWidth).size
    }

    @available(iOS 16.0, *)
    func placeSubviews(in bounds: CGRect,
                       proposal: ProposedViewSize,
                       subviews: Subviews,
                       cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = layout(sizes: sizes, spacing: spacing, containerWidth: bounds.width).offsets

        for (offset, subview) in zip(offsets, subviews) {
            subview.place(at: CGPoint(x: offset.x + bounds.minX, y: offset.y + bounds.minY),
                          proposal: .unspecified)
        }
    }
}
