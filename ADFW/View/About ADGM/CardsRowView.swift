//
//  CardsRowView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import SwiftUICore
import SwiftUI

import SwiftUI

struct CardsRowView: View {
    let cards: [Banner_content]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(cards, id: \.title) { card in
                    VStack(alignment: .leading, spacing: 8) {
                        if let imageurl = card.image_url, let url = URL(string: imageurl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 100)
                                    .clipped()
                            } placeholder: {
                                Color.gray.frame(height: 100)
                            }
                        }
                     
                        Text(card.title ?? "")
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(Color(UIColor(hex: "#0088FF")))
                            .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                            .lineLimit(1)
                            
                        Text(card.des ?? "") // ✅ Fix: used `des` instead of `description`
                            .foregroundColor(Color(UIColor.black))
                            .font(Font(FontManager.font(weight: .regular, size: 13)))
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(3)
                        
                        HStack(alignment: .bottom, spacing: 4) {
                            Text("Read more")
                                .foregroundColor(Color(UIColor(hex: "#0088FF")))
                                .font(Font(FontManager.font(weight: .medium, size: 13)))
                            
                            Image(systemName: "arrow.up.right")
                                .resizable()
                                .foregroundColor(Color(UIColor(hex: "#0088FF")))
                                .frame(width: 7, height: 7)
                                .padding(.bottom,2)
                        }
                    }
                    .frame(width: 200, alignment: .leading)
                }
            }
            .padding()
        }
        .padding(.vertical)
        .background(Color(UIColor(hex: "#E5F0F0")))
        .padding(.bottom,30)
    }
}



#Preview {
    CardsRowView(cards: [])
}
