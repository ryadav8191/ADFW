//
//  NotificationView.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//

import SwiftUICore
import SwiftUI

struct NotificationView: View {
    @State private var showMenu = false
    @ObservedObject var viewModel: NotificationViewModel

    let onBack: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                // Custom navigation bar
                HStack {
                    Button(action: { onBack() }) {
                        Image("back")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                    .frame(width: 50, height: 50)

                    Text("Notification")
                        .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                        .foregroundColor(.primary)

                    Spacer()

                    Button(action: {
                        withAnimation { showMenu.toggle() }
                    }) {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing, 8)
                }

                Divider()

                ScrollView {
                    VStack(spacing: 12) {
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                        } else if viewModel.notifications.isEmpty {
                            Text("No notifications found.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(viewModel.notifications, id: \.id) { item in
                                NotificationCardView(data: item)
                                    .padding(.horizontal)
                                    .onAppear {
                                        viewModel.loadMoreIfNeeded(currentItem: item, in: UIApplication.shared.connectedScenes
                                            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                                            .first ?? UIView())
                                    }
                            }

                            if viewModel.isLoading {
                                ProgressView()
                                    .padding(.vertical)
                            }
                        }
                    }
                    .padding(.top)
                }
            }

            // Popup Menu
            if showMenu {
                VStack(alignment: .leading, spacing: 0) {
                    Button(action: {
                        print("Clear all tapped")
                        withAnimation { showMenu = false }
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
            if showMenu {
                withAnimation { showMenu = false }
            }
        }
        .onAppear {
            viewModel.resetAndFetch(in: UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .first ?? UIView())
        }
    }
}



//#Preview {
//    NotificationView(onBack: {})
//}
