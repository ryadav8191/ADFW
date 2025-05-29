//
//  HeaderSectionView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import SwiftUICore
import SwiftUI


struct HeaderSectionView: View {
    let header: HeaderInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: header.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(height: 200)
            .clipped()
            
            HStack(alignment: .center) {
                Rectangle() // Vertical blue bar
                    .fill(Color.blue)
                    .frame(width: 3, height: 50)
                    .padding(.trailing, 0)
               
                VStack(alignment: .leading){
                    Text(header.title).font(Font(FontManager.font(weight: .semiBold, size: 19)))
                    Text(header.subtitle).font(Font(FontManager.font(weight: .bold, size: 19))).foregroundColor(Color(UIColor.blueColor))
                }
            }
            Text(header.description).font(Font(FontManager.font(weight: .regular, size: 15))).foregroundColor(Color(UIColor.lightBlue))
                //.padding(12)
        }
        .padding()
    }
}


#Preview {
  
}
