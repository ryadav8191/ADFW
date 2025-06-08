//
//  TicketView.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//


import SwiftUI

struct TicketView: View {
    @State private var expandedDayID: Int? = nil
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Top Bar
            HStack(alignment: .center, spacing: 16) {
                Button(action: {
                    onBack()
                }) {
                    Image("back")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                }
                

                Text("My ")
                    .foregroundColor(Color.black)
                    .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                + Text("Tickets")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .bold, size: 19)))
                   

                Spacer()
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)

            ScrollView {
                VStack(spacing: 16) {
                    // Ticket Info Card
                    VStack(spacing: 12) {
                        Image("qr_logo")
                            .resizable()
                            .frame(width: 150, height: 65)
                            .padding()

                        VStack(spacing: 0) {
                            Image("qr")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200, maxHeight: 200)
                                .padding()
                            Text("RBQXCW")
                                .font(Font(FontManager.font(weight: .regular, size: 20)))
                        }
                        .padding(12)
                        .background(Color.white)

                        Text("SINGLE DAY PASS:")
                            .font(Font(FontManager.font(weight: .semiBold, size: 26)))
                            .foregroundColor(Color(UIColor.blueColor))

                        Text("RESOLVE")
                            .font(Font(FontManager.font(weight: .semiBold, size: 36)))
                            .foregroundColor(Color(UIColor.blueColor))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.blueColor.withAlphaComponent(0.1)))
                    .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 16)

                    // Ticket Benefits Button
                    HStack(alignment: .top, spacing: 8) {
                        Rectangle()
                            .foregroundColor(Color(UIColor.blueColor))
                            .frame(width: 2, height: 24)

                        Button(action: {
                            // Ticket Benefits tapped
                        }) {
                            HStack(spacing: 0) {
                                Text("Ticket ")
                                    .foregroundColor(.primary)
                                Text("Benefits")
                                    .foregroundColor(Color(UIColor.blueColor))
                            }
                            .padding(.leading, 4)
                            .font(Font(FontManager.font(weight: .semiBold, size: 20)))
                        }
                        .buttonStyle(PlainButtonStyle())

                        Spacer()
                    }
                    .padding(.leading, 16)

                    // Expandable Event Sections
                    VStack(spacing: 10) {
                        ForEach(eventDays) { day in
                            VStack(alignment: .leading, spacing: 0) {
                                // Day Header
                                Button(action: {
                                    withAnimation {
                                        expandedDayID = (expandedDayID == day.id) ? nil : day.id
                                    }
                                }) {
                                    HStack {
                                        Text("Day \(day.id) - \(day.date)")
                                            .font(Font(FontManager.font(weight: .semiBold, size: 16)))
                                            .foregroundColor(.white)
                                        Spacer()
                                        Image(expandedDayID == day.id ? "downArrowWhite" : "upArrowWhite") //
                                            .foregroundColor(.white)
                                            
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(UIColor.blueColor))
                                    .cornerRadius(3)
                                }

                                // Event List
                                if expandedDayID == day.id {
                                    VStack(alignment: .leading, spacing: 16) {
                                        ForEach(day.events, id: \.self) { event in
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(event.name)
                                                    .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                                                    .foregroundColor(.black)

                                                HStack(spacing: 4) {
                                                    Image("geo-alt")
                                                        .foregroundColor(.blue)
                                                    Text(event.location)
                                                        .font(Font(FontManager.font(weight: .medium, size: 15)))
                                                        .foregroundColor(Color(UIColor.lightBlue))
                                                }
                                            }
                                            .padding(.vertical, 8)
                                            .padding(.horizontal)
                                           // .background(Color.white)
                                        }
                                    }
                                    //.padding(.horizontal)
                                    .padding(.top, 8)
                                }
                            }
                           // .background(Color(UIColor.systemGray6))
                           // .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical)
            }
        }
    }
}


// MARK: - Mock Data

struct EventDay: Identifiable {
    let id: Int
    let date: String
    let events: [Event]
}

struct Event: Hashable {
    let name: String
    let location: String
}

let eventDays: [EventDay] = [
    EventDay(id: 1, date: "09th December", events: []),
    EventDay(id: 2, date: "10th December", events: [
        Event(name: "Asset Abu Dhabi", location: "ADFW Arena"),
        Event(name: "Venture Stage", location: "Falcon Square"),
        Event(name: "The International Family Office Congress", location: "The Executive Stage"),
        Event(name: "T.R.I Summit", location: "ADFW Auditorium"),
        Event(name: "Entertainment", location: "Capital Square"),
        Event(name: "Entertainment - Urban Experience", location: "Capital Square")
    ]),
    EventDay(id: 3, date: "10th December", events: []),
    EventDay(id: 4, date: "10th December", events: [
        Event(name: "Asset Abu Dhabi", location: "ADFW Arena"),
        Event(name: "Venture Stage", location: "Falcon Square"),
        Event(name: "The International Family Office Congress", location: "The Executive Stage"),
        Event(name: "T.R.I Summit", location: "ADFW Auditorium"),
        Event(name: "Entertainment", location: "Capital Square"),
        Event(name: "Entertainment - Urban Experience", location: "Capital Square")
    ])
]

#Preview {
    TicketView(onBack: {})
}
