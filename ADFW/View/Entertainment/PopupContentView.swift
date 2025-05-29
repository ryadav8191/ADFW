//
//  ContentView.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//

import SwiftUICore
import SwiftUI


struct PopupContentView: View {
    @State private var showCalendar = false
    @State private var selectedDate = "10 DECEMBER"

    var body: some View {
        ZStack {
            VStack {
                // Your main UI here
                Button(action: {
                    showCalendar = true
                }) {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                }

                // Your ScrollView, EventCards, etc.
            }

            if showCalendar {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showCalendar = false
                    }

                CalendarPopupView(selectedDate: $selectedDate, isPresented: $showCalendar)
                    .transition(.scale)
            }
        }
    }
}
