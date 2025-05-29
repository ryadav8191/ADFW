//
//  EnquirySectionView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import SwiftUI
import SwiftUI

struct EnquirySectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 8) {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 3, height: 24)
                
                Text("How Can ")
                    .foregroundColor(Color(UIColor.black))
                    .font(Font(FontManager.font(weight: .semiBold, size: 19))) +
                Text("We Help You?")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .semiBold, size: 19)))
            }
            
            Text("To help us manage your enquiry better, please click below.")
                .foregroundColor(Color(UIColor.lightBlue))
                .font(Font(FontManager.font(weight: .medium, size: 15)))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(8)

            Button(action: {
                // Navigate to enquiry form
                print("hii")
            }) {
                HStack {
                    Text("MAKE AN ENQUIRY")
                        .font(Font(FontManager.font(weight: .semiBold, size: 16)))
                    Image(systemName: "arrow.right")
                }
                .padding(.horizontal, 16)
                .frame(height: 36)
                .background(Color.blue)
                .foregroundColor(.white)
                
            }
            .frame(maxWidth: .infinity, alignment: .center) // Center the button horizontally
        }
        .padding()
        .background(Color(UIColor(hex: "#E5F0F0")))
    }
}
