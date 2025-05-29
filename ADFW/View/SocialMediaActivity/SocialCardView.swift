//
//  SocialCardView.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import SwiftUICore
import SwiftUI

struct SocialCardView: View {
    let post: SocialPost

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(post.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(4)

//            Text(post.title)
//                .font(.headline)

            Text(post.description)
                .font(Font(FontManager.font(weight: .regular, size: 14)))
                .foregroundColor(Color(UIColor(hex: "#002646")))

           

            HStack(spacing: 16.0) {
                Text(post.tags)
                    .font(Font(FontManager.font(weight: .regular, size: 14)))
                    .foregroundColor(Color(UIColor(hex: "#6A6A6A")))
                Spacer()
                Image(systemName: post.platform.iconName)
                    .foregroundColor(.blue)
                    .font(.title3)
            }
            
        }
        .padding()
        .background(Color(.white))
       // .cornerRadius(15)
        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    SocialCardView(post: SocialPost(platform: .facebook, imageName: "wsdwcew", title: "wedwedwd", description: "wedwdwe", tags: "wedwedw"))
}
