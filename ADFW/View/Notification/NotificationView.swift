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
    @State private var showMenu = false
    
    let notifications: [NotificationItem] = [
        NotificationItem(date: "Mar. 30", time: "12:38 pm", title: "Live Session Started", description: "An Address From The Mubadala", iconName: "live_icon", isLive: true),
        NotificationItem(date: "09 Dec", time: "12:38 pm", title: "New Recording Available", description: "An Address From The UAE Minister Of Economy", iconName: "play_icon", isLive: false),
        NotificationItem(date: "09 Dec", time: "12:38 pm", title: "Live Session Started", description: "An Address From The Mubadala Investment Company", iconName: "live_icon", isLive: false)
    ]
    
    let onBack: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                // Custom navigation bar
                HStack {
                    Button(action: {
                        onBack()
                    }) {
                        Image("back")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                    .frame(width: 50,height: 50)
                   // .background(.red)

                    Text("Notification")
                        .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                        .foregroundColor(.primary)

                    Spacer()

                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing, 8) // Some spacing from the edge
                }
              ///  .background(.red)
              ///  .padding(8)
                
                
                
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
           // .background(.green)

            // Popup Menu
            if showMenu {
                VStack(alignment: .leading, spacing: 0) {
                    Button(action: {
                        print("Clear all tapped")
                        withAnimation {
                            showMenu = false
                        }
                    }) {
                        Text("Clear Notification")
                            .font(Font(FontManager.font(weight: .medium, size: 14)))
                            .foregroundColor(.black)
                            .padding()
                            
                            .frame(maxWidth: 170, alignment: .center)
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)
                .padding(.top, 50)
                .padding(.trailing, 16)
            }
        }
        .onTapGesture {
            // Hide the menu if tapped outside
            if showMenu {
                withAnimation {
                    showMenu = false
                }
            }
        }
       // .background(.red)
    }

}


#Preview {
    NotificationView(onBack: {})
}
