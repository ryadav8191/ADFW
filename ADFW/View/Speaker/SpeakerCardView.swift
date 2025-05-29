//
//  Speaker.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//


import SwiftUI

struct SpeakerDemo: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let title: String
    let badgeColors: [Color]
}

struct ContentView: View {
    let speakers: [SpeakerDemo] = [
        SpeakerDemo(imageName: "women1", name: "H.E. Ahmed Jasim Al Zaabi", title: "Chairman, ADGM & Abu Dhabi Dept. of Economic Development", badgeColors: [.purple]),
        SpeakerDemo(imageName: "women1", name: "H.H. Sheikha Shamma bint Sultan bin Khalifa Al Nahyan", title: "President & CEO, UICCA", badgeColors: [.cyan]),
        SpeakerDemo(imageName: "women1", name: "H.R.H. Prince Khaled bin Alwaleed bin Talal Al Saud", title: "Founder & CEO, KBW Ventures", badgeColors: [.teal]),
        SpeakerDemo(imageName: "women1", name: "H.E. Abdulla Bin Touq Al Marri", title: "Minister of Economy, Govt. of UAE", badgeColors: [.blue]),
        SpeakerDemo(imageName: "women1", name: "H.E. Mariam bint Mohammed Saeed Hareb Almheiri", title: "Minister of Climate Change & Environment, UAE", badgeColors: [.blue]),
        SpeakerDemo(imageName: "women1", name: "Ray Dalio", title: "Founder & CIO Mentor, Bridgewater Associates, LP", badgeColors: [.blue, .purple, .teal])
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(speakers) { speaker in
                    SpeakerCardView(speaker: speaker)
                }
            }
            .padding()
        }
    }
}

struct SpeakerCardView: View {
    let speaker: SpeakerDemo
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Image(speaker.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 160)
                    .clipped()
                   // .cornerRadius(8)
                
                HStack(spacing: 4) {
                    ForEach(speaker.badgeColors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(6)
            }
            
            Text(speaker.name)
                .font(.headline)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(speaker.title)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color.white)
       // .cornerRadius(12)
        //.shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
