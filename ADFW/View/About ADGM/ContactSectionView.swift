//
//  ContactSectionView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import SwiftUICore
import SwiftUI


import SwiftUI

import SwiftUI

struct ContactSectionView: View {
    let contactInfo: [Contact]
    let socialMediaIcons: [String] // Icons should match socialMediaLinks

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {

          
            
            HStack {
                Rectangle() // Vertical blue bar
                    .fill(Color.blue)
                    .frame(width: 3, height: 24)
                    .padding(.trailing, 0)
                Text("Contact ")
                    .foregroundColor(Color(UIColor.black))
                    .font(Font(FontManager.font(weight: .semiBold, size: 19))) +
                Text("& Support")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                
                    
            }

            // Address
            VStack(alignment: .leading, spacing: 16) {
                Text(contactInfo.first?.address?.heading ?? "")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .semiBold, size: 15)))

                VStack(alignment: .leading) {
                    Text(contactInfo.first?.address?.building ?? "")
                        .foregroundColor(Color(UIColor.lightBlue))
                        .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                    Text(contactInfo.first?.address?.location ?? "")
                        .foregroundColor(Color(UIColor.lightBlue))
                        .font(Font(FontManager.font(weight: .medium, size: 15)))
                    Text(contactInfo.first?.address?.po_box ?? "")
                        .foregroundColor(Color(UIColor.lightBlue))
                        .font(Font(FontManager.font(weight: .medium, size: 15)))
                    Text(contactInfo.first?.address?.city ?? "")
                        .foregroundColor(Color(UIColor.lightBlue))
                        .font(Font(FontManager.font(weight: .medium, size: 15)))
                }
            }

            // Hours
            VStack(alignment: .leading, spacing: 16) {
                Text(contactInfo.first?.working_hours?.heading ?? "")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .semiBold, size: 15)))

                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        
                        Text(contactInfo.first?.working_hours?.monday_to_thursday?.days ?? "")
                                .foregroundColor(Color(UIColor.lightBlue))
                                .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                        Text(contactInfo.first?.working_hours?.monday_to_thursday?.time ?? "")
                                .foregroundColor(Color(UIColor.lightBlue))
                                .font(Font(FontManager.font(weight: .medium, size: 15)))
                    
                    }

                    Spacer(minLength: 20)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(contactInfo.first?.working_hours?.friday?.days ?? "")
                                .foregroundColor(Color(UIColor.lightBlue))
                                .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                        Text(contactInfo.first?.working_hours?.friday?.time ?? "")
                                .foregroundColor(Color(UIColor.lightBlue))
                                .font(Font(FontManager.font(weight: .medium, size: 15)))
                    }
                }
                ///.padding(.top, 8)
            }

            // Social Media
            VStack(alignment: .leading, spacing: 16) {
                Text(contactInfo.first?.social_media?.heading ?? "")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .semiBold, size: 15)))

                HStack(spacing: 16) {
                    ForEach(contactInfo.first?.social_media?.platforms ?? [], id: \.img) { platform in
                        if let linkStr = platform.link,
                           let url = URL(string: linkStr),
                           let imageURLStr = platform.img,
                           let imageURL = URL(string: imageURLStr) {

                            Link(destination: url) {
                                AsyncImage(url: imageURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView() // or a default icon/image
                                }
                                .frame(width: 24, height: 24)
                            }
                        }
                    }
                }
            }


        }
        .padding(.top,30)
        .padding(.bottom,30)
        .padding()
       // .background(Color(UIColor(hex: "#E5F0F0")))
       
    }
}

