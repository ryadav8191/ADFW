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
                    .font(Font(FontManager.font(weight: .medium, size: 12)))
                    .foregroundColor(Color(UIColor.lightBlue))
                Text(item.time)
                    .font(Font(FontManager.font(weight: .medium, size: 12)))
                    .foregroundColor(Color(UIColor.lightBlue))
                Image(item.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 24)
                    
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(Font(FontManager.font(weight: .semiBold, size: 14)))
                    .foregroundColor(Color(UIColor.lightBlue))
                Text(item.description)
                    .font(Font(FontManager.font(weight: .regular, size: 12)))
                    .foregroundColor(Color(UIColor.lightBlue))
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
