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
    let contactInfo: ContactInfo
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
                Text("Address")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .semiBold, size: 15)))

                VStack(alignment: .leading) {
                    Text(contactInfo.address)
                        .foregroundColor(Color(UIColor.lightBlue))
                        .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                    Text("Al Maryah Island")
                        .foregroundColor(Color(UIColor.lightBlue))
                        .font(Font(FontManager.font(weight: .medium, size: 15)))
                    Text("PO Box 111999")
                        .foregroundColor(Color(UIColor.lightBlue))
                        .font(Font(FontManager.font(weight: .medium, size: 15)))
                    Text("Abu Dhabi, UAE")
                        .foregroundColor(Color(UIColor.lightBlue))
                        .font(Font(FontManager.font(weight: .medium, size: 15)))
                }
            }

            // Hours
            VStack(alignment: .leading, spacing: 16) {
                Text("General working hours")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .semiBold, size: 15)))

                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(contactInfo.hours.filter { $0.day.contains("Monday") }, id: \.id) { hour in
                            Text(hour.day)
                                .foregroundColor(Color(UIColor.lightBlue))
                                .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                            Text(hour.time)
                                .foregroundColor(Color(UIColor.lightBlue))
                                .font(Font(FontManager.font(weight: .medium, size: 15)))
                        }
                    }

                    Spacer(minLength: 20)

                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(contactInfo.hours.filter { $0.day.contains("Friday") }, id: \.id) { hour in
                            Text(hour.day)
                                .foregroundColor(Color(UIColor.lightBlue))
                                .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                            Text(hour.time)
                                .foregroundColor(Color(UIColor.lightBlue))
                                .font(Font(FontManager.font(weight: .medium, size: 15)))
                        }
                    }
                }
                ///.padding(.top, 8)
            }

            // Social Media
            VStack(alignment: .leading, spacing: 16) {
                Text("You can find us on social media")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .semiBold, size: 15)))

                HStack(spacing: 16) {
                    ForEach(Array(zip(contactInfo.socialMediaLinks.indices, contactInfo.socialMediaLinks)), id: \.0) { index, url in
                        Link(destination: url) {
                            Image(socialMediaIcons[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue)
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
