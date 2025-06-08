//
//  SocialMediaActivityView.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import SwiftUICore
import SwiftUI



struct SocialMediaActivityView: View {
   let posts: [SocialPost]
    let onBack: () -> Void

    var body: some View {
           
        VStack {
            
            HStack(spacing: 16) {
                Button(action: {
                    onBack()
                    
                    
                }) {
                    Image("back")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                }
               
                Text("Social Media ") ///Session overview  social media activity
                    .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                + Text("Activity")
                    .foregroundColor(.blue)
                    .font(Font(FontManager.font(weight: .bold, size: 19)))
                    .foregroundColor(Color(UIColor.blueColor))
                Spacer()

            }
            
            .padding()
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(posts) { post in
                        SocialCardView(post: post)
                            .onTapGesture {
                                print("hiii")
                            }
                    }
                }
                .padding()
            }
        }
       
        
            

    }
}

#Preview {
    SocialMediaActivityView(posts: [SocialPost(
        platform: .instagram,
        imageName: "post1",
        title: "ADGM's contribution to Abu Dhabi’s stature...",
        description: "H.E. Ahmed Jasim Al Zaabi, Chairman of ADGM, highlights ADGM's pivotal role in driving Abu Dhabi's economy forward, reflecting its strategic vision and commitment to excellence. ADGM's exceptional performance in H1 2024 positions the UAE as a leading global financial powerhouse.",
        tags: "#ADGM #AhmedJasimAlZaabi #EconomicLeadership #StrategicVision #Excellence"
    )], onBack: {})
}
