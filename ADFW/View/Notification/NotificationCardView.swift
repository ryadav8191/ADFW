//
//  NotificationCardView.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//


import SwiftUI

import SwiftUI

struct NotificationCardView: View {
    let data: NotificationData

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text(Helper.formattedDateString(from: data.date ?? "") ?? "")
                    .font(Font(FontManager.font(weight: .medium, size: 12)))
                    .foregroundColor(Color(UIColor.lightBlue))
                Text(Helper.formattedTimeString(from: data.date ?? "") ?? "")
                    .font(Font(FontManager.font(weight: .medium, size: 12)))
                    .foregroundColor(Color(UIColor.lightBlue))

                if let imageUrl = data.logo, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 36, height: 24)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 36, height: 24)
                        case .failure:
                            Image("placeholder") // fallback image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 36, height: 24)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image("live_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 24)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(data.title ?? "")
                    .font(Font(FontManager.font(weight: .semiBold, size: 14)))
                    .foregroundColor(Color(UIColor.lightBlue))
                Text(data.description ?? "")
                    .font(Font(FontManager.font(weight: .regular, size: 12)))
                    .foregroundColor(Color(UIColor.lightBlue))
            }

            Spacer()
        }
        .padding()
        .cornerRadius(10)
    }
}

    //#Preview {
    //    NotificationCardView(item: NotificationItem(date: "Mar. 30", time: "12:38 pm", title: "Live Session Started", description: "An Address From The Mubadala Investment CompanyAddress From The Mubadala Investment CompanyAddress From The Mubadala Investment CompanyAddress From The Mubadala Investment Company", iconName: "live_icon", isLive: true))
    //}
