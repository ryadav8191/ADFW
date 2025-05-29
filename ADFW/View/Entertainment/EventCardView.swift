//
//  EventCardView.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//

import SwiftUICore
import SwiftUI


struct EventCardView: View {
    let event: Entertainment

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            // 👇 Your original image code remains unchanged
            ZStack(alignment: .topTrailing) {
                Image(event.imageName)
                    .resizable()
                    .frame(width: 109, height: 146)
            }

            // 👇 Updated layout for text and info boxes
            VStack(alignment: .leading, spacing: 10) {
                Text(event.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                   

                Text(event.description)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.8))
                    .fixedSize(horizontal: false, vertical: true)

                VStack(alignment: .leading, spacing: 8) {
                    InfoBox(icon: "clock", text: event.time)
                    InfoBox(icon: "calendar", text: event.location)
                }
            }
        }
        .padding(.horizontal)
    }
}


struct InfoBox: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 8) {
            Image(icon)
                .resizable()
                .frame(width: 15,height: 15)
            Text(text)
        }
        .font(.system(size: 13, weight: .medium))
        .foregroundColor(.white)
     .padding(.vertical, 8)
      .padding(.horizontal, 12)
       
        .overlay(
            RoundedRectangle(cornerRadius: 1)
                .stroke(Color.white, lineWidth: 1)
        )
    }
}
