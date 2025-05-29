//
//  NotificationCardView.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//


import SwiftUI

struct NotificationCardView: View {
    let item: NotificationItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading) {
                Text(item.date)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(item.time)
                    .font(.caption)
                    .foregroundColor(.gray)
                Image(item.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()

          
        }
        .padding()
        .background(item.isLive ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    NotificationCardView(item: NotificationItem(date: "Mar. 30", time: "12:38 pm", title: "Live Session Started", description: "An Address From The Mubadala Investment CompanyAddress From The Mubadala Investment CompanyAddress From The Mubadala Investment CompanyAddress From The Mubadala Investment Company", iconName: "live_icon", isLive: true))
}
