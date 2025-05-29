//
//  HeaderView.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//

import SwiftUICore
import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("header_background") // Replace with your actual asset name
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipped()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            VStack(spacing: 12) {
                Text("Entertainment @ADFW")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text("Get ready to unwind and experience evenings filled with positive vibes, good energy and entertainment, featuring an exciting lineup of artists at ADFW 2024.")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
            }
            .padding(8)
            .padding(.bottom, 24)
        }
    }
}


#Preview {
    HeaderView()
}
