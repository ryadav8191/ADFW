//
//  SpeakerProfileView.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//


import SwiftUI


import SwiftUI

struct SpeakerProfileView: View {
    let profile: SpeakerProfile
    var onClose: (() -> Void)? = nil

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
                    Image(profile.imageName)
                        .resizable()
                        .frame(width: 105, height: 115)
                        .clipShape(RoundedRectangle(cornerRadius: 0))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(profile.name)
                            .font(Font(FontManager.font(weight: .bold, size: 18)))
                            .foregroundColor(Color(UIColor.lightBlue))

                        Text(profile.title)
                            .font(Font(FontManager.font(weight: .regular, size: 12)))
                            .foregroundColor(Color(UIColor(hex: "#555555")))
                    }
                }

                // Descriptions
                Text(profile.descriptionShort)
                    .font(Font(FontManager.font(weight: .regular, size: 14)))
                    .foregroundColor(Color(UIColor(hex: "#0D0D0D")))

                Text(profile.descriptionLong)
                    .font(Font(FontManager.font(weight: .regular, size: 12)))
                    .foregroundColor(Color(UIColor(hex: "#0D0D0D")))

                // Wrapped tags using FlowLayout
                if #available(iOS 17.0, *) {
                    AnyLayout(FlowLayout(spacing: 8)) {
                        ForEach(profile.tags) { tag in
                            TagView(text: tag.title, color: Color(tag.color))
                        }
                    }
                    .padding(.top, 8)
                }

               

                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(0)
        .padding()
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

#Preview {
    SpeakerProfileView(profile: SpeakerProfile(
        name: "H.E. Ahmed Jasim Al Zaabi",
        title: "Chairman, ADGM & Abu Dhabi Dept. Of Economic Development",
        descriptionShort: "His Excellency Ahmed Jasim Al Zaabi is member of the Abu Dhabi Executive Council and Chairman of the Abu Dhabi Department of Economic Development (ADDED), the catalyst for economic growth in the emirate. In this role, H.E. is spearheading strategies and initiatives to further enhance the soaring, diversified, smart, and sustainable “Falcon Economy”.A seasoned leader with a proven track record in delivering results, H.E. Al Zaabi has long-standing experience in the finance and investments sector, wherein he has managed and executed multi-billion-dollar investment transactions and led numerous restructurings and turnarounds across a multitude of sectors. H.E. is also the Chairman of Abu Dhabi Global Market (ADGM), the international financial centre located in the UAE capital and cementing Abu Dhabi’s status as a leading financial hub and “Capital of Capital”. At the helm of ADGM, H.E. has been",
        descriptionLong: "A seasoned leader with a proven track record in delivering results...",
        imageName: "person1", // Your image asset
        tags: [
            Tag(title: "Abu Dhabi Economic Forum", color: .blue),
            Tag(title: "Asset Abu dhabi", color: .cyan),
            Tag(title: "Fintech Abu dhabi", color: .blue),
            Tag(title: "R.A.C.E. Sustainability Summit", color: .black)
        ]
    ))
}


import SwiftUI

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
