//
//  TicketView.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//


import SwiftUI

struct TicketView: View {
    @State private var expandedDayID: String? = nil
    @StateObject private var viewModel = TicketViewModel()
    var ticketNumber: String = LocalDataManager.getLoginResponse()?.ticketNumber ?? ""
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
                            Text(LocalDataManager.getLoginResponse()?.ticketNumber ?? "")
                                .font(Font(FontManager.font(weight: .regular, size: 20)))
                        }
                        .padding(12)
                        .background(Color.white)

//                        Text("SINGLE DAY PASS:")
//                            .font(Font(FontManager.font(weight: .semiBold, size: 26)))
//                            .foregroundColor(Color(UIColor.blueColor))

//                        Text("LocalDataManager.getLoginResponse()?.ticket_id?.title" ?? "")
//                            .font(Font(FontManager.font(weight: .semiBold, size: 36)))
//                            .foregroundColor(Color(UIColor.blueColor))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.blueColor.withAlphaComponent(0.1)))
                   // .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.blue, lineWidth: 1))
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
                                    .foregroundColor(.black)
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
                    // Expandable Ticket Benefits Section
                    VStack(spacing: 10) {
                        ForEach(viewModel.ticketDays, id: \.day) { day in
                            VStack(alignment: .leading, spacing: 0) {
                                // Day Header
                                Button(action: {
                                    withAnimation {
                                        expandedDayID = (expandedDayID == day.day) ? nil : day.day
                                    }
                                }) {
                                    HStack {
                                        Text(day.day ?? "")
                                            .font(Font(FontManager.font(weight: .semiBold, size: 16)))
                                            .foregroundColor(.white)
                                        Spacer()
                                        Image(expandedDayID == day.day ? "downArrowWhite" : "upArrowWhite")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(UIColor.blueColor))
                                    .cornerRadius(3)
                                }

                                // Benefits List
                                if expandedDayID == day.day {
                                    VStack(alignment: .leading, spacing: 16) {
                                        ForEach(day.benefits ?? [], id: \.id) { benefit in
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(benefit.name ?? "")
                                                    .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                                                    .foregroundColor(.black)

                                                if let location = benefit.venue?.name {
                                                    HStack(spacing: 4) {
                                                        Image("geo-alt")
                                                        Text(location)
                                                            .font(Font(FontManager.font(weight: .medium, size: 15)))
                                                            .foregroundColor(Color(UIColor.lightBlue))
                                                    }
                                                }
                                            }
                                            .padding(.vertical, 8)
                                            .padding(.horizontal)
                                        }
                                    }
                                    .padding(.top, 8)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)

                    
                }
                .padding(.vertical)
            }
        }
        .onAppear {
                   if let window = UIApplication.shared.windows.first {
                       self.viewModel.load(ticketNumber: ticketNumber, in: window)
                   }
               }
        .background(Color.white)
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
