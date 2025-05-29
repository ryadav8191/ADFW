//
//  EntertainmentHeaderBar.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//

import SwiftUICore
import SwiftUI


struct EntertainmentHeaderBar: View {
    @Binding var showCalendarPopup: Bool
        @Binding var selectedDate: String
        @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button(action: {
                    // Handle back action
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding(.leading, 16)
                
                Text("Entertainment ")
                    .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                    .foregroundColor(.black) +
                Text("@ADFW")
                    .font(Font(FontManager.font(weight: .bold, size: 19)))
                    .foregroundColor(.blue)
                
                Spacer()
            }
            
            HStack(spacing: 8) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search...", text: $searchText)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 10)
                .frame(height: 40) // 👈 Uniform height
                .background(Color.white)
                .cornerRadius(3)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(UIColor(hex: "#A3A6A7")), lineWidth: 1)
                )
               
                
                
                // Calendar Button
                Button(action: {
                    showCalendarPopup = true
                }) {
                    Image("calender_filter")
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40) // 👈 Uniform box
                        .background(Color.white)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 3)
//                                .stroke(Color(UIColor(hex: "#A3A6A7")), lineWidth: 1)
//                        )
                        .cornerRadius(3)
                }

                // Filter Button
                Button(action: {
                    OverlayPresenter.showFilterOverlay()
                }) {
                    Image("filter")
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40) // 👈 Uniform box
                        .background(Color.white)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 3)
//                                .stroke(Color(UIColor(hex: "#A3A6A7")), lineWidth: 1)
//                        )
                        .cornerRadius(3)
                }
            }
            .padding(.horizontal, 16)

        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
   // EntertainmentHeaderBar()
}
