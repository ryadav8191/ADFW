//
//  HeaderSectionView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import SwiftUICore
import SwiftUI


struct HeaderSectionView: View {
    let header: AboutAdgmAttributes

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let image_url = header.banner_img, let url = URL(string: image_url) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(height: 200)
                .clipped()
            }
        
            
            HStack(alignment: .center) {
                Rectangle() // Vertical blue bar
                    .fill(Color.blue)
                    .frame(width: 1, height: 70)
                    .padding(.trailing, 0)
               
                VStack(alignment: .leading){
                    Text(header.banner_tittle ?? "").font(Font(FontManager.font(weight: .semiBold, size: 19)))
                    Text(header.banner_sub_tittle ?? "").font(Font(FontManager.font(weight: .bold, size: 19))).foregroundColor(Color(UIColor.blueColor))
                }
            }
            Text(header.banner_des ?? "").font(Font(FontManager.font(weight: .regular, size: 15))).foregroundColor(Color(UIColor.lightBlue))
                //.padding(12)
        }
        .padding()
    }
}


#Preview {
  
}
