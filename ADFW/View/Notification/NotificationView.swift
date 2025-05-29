//
//  NotificationView.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//

import SwiftUICore
import SwiftUI

import SwiftUI

struct NotificationView: View {
    let notifications: [NotificationItem] = [
        NotificationItem(date: "Mar. 30", time: "12:38 pm", title: "Live Session Started", description: "An Address From The Mubadala", iconName: "live_icon", isLive: true),
        NotificationItem(date: "09 Dec", time: "12:38 pm", title: "New Recording Available", description: "An Address From The UAE Minister Of Economy", iconName: "play_icon", isLive: false),
        NotificationItem(date: "09 Dec", time: "12:38 pm", title: "Live Session Started", description: "An Address From The Mubadala Investment Company", iconName: "live_icon", isLive: false)
    ]
    
    
    let onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom navigation bar
            HStack {
                Button(action: {
                    // Handle back action
                    onBack()
                    
                }) {
                    Image("back")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                }
                
                Text("Notification")
                    .font(Font(FontManager.font(weight: .semiBold, size: 19)))
//                    .underline(true, color: Color.blue.opacity(0.7))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: {
                    // Handle menu action
                }) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .foregroundColor(.primary)
                }
            }
            .padding()
            
            Divider()
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(notifications) { item in
                        NotificationCardView(item: item)
                            .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
        }
    }
}

//#Preview {
//   // NotificationView(onBack: {})
//}
