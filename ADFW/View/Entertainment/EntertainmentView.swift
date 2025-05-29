//
//  EntertainmentView.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//


import SwiftUI

struct Entertainment: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let time: String
    let location: String
    let imageName: String
    let badge: String?
}

struct DayEvents {
    let dayTitle: String
    let events: [Entertainment]
}

struct EntertainmentView: View {
    
    let sampleData = [
        DayEvents(dayTitle: "DEC 09 – Day 1", events: [
            Entertainment(title: "DJ Natalie",
                  description: "Award-winning DJ, setting the rhythm for a vibrant nightlife, one beat at a time.",
                  time: "10:30AM – 11:30AM",
                  location: "Capital Square",
                  imageName: "Entertainment_Person",
                  badge: "D"),

            Entertainment(title: "Abri Duo",
                  description: "UAE-based singer-songwriter...",
                  time: "10:30AM Onwards",
                  location: "Capital Square",
                  imageName: "abri_duo",
                  badge: "M")
        ]),

        DayEvents(dayTitle: "DEC 10 – Day 2", events: [
            Entertainment(title: "DJ Liutik",
                  description: "Moldovan DJ who plays...",
                  time: "10:30AM Onwards",
                  location: "Capital Square",
                  imageName: "dj_liutik",
                  badge: nil),

            Entertainment(title: "Sandra Sahi",
                  description: "Dubai-based singer-songwriter...",
                  time: "10:30AM Onwards",
                  location: "Capital Square",
                  imageName: "sandra_sahi",
                  badge: nil)
        ])
    ]
    @State private var showCalendarPopup = false
        @State private var selectedDate = "10 DECEMBER"

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                EntertainmentHeaderBar(
                    showCalendarPopup: $showCalendarPopup,
                    selectedDate: $selectedDate
                )
                .frame(maxWidth: .infinity)
                .padding(.horizontal)

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        HeaderView()
                            .padding(.vertical, 0)

                        ForEach(sampleData, id: \.dayTitle) { day in
                            VStack(alignment: .leading, spacing: 16) {
                                Text(day.dayTitle)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.horizontal, 16)

                                ForEach(day.events) { event in
                                    EventCardView(event: event)
                                        .padding(.horizontal, 16)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20) // Only here
                }
                .background(Color.black.ignoresSafeArea())
            }

            // Calendar Popup
            if showCalendarPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showCalendarPopup = false
                    }

                CalendarPopupView(
                    selectedDate: $selectedDate,
                    isPresented: $showCalendarPopup
                )
                
                .transition(.scale)
            }
        }
    }

    }

struct EntertainmentView_Previews: PreviewProvider {
    static var previews: some View {
        EntertainmentView()
    }
}


