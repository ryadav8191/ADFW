//
//  TicketView.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//


import SwiftUI

struct TicketView: View {
    @State private var expandedDays: Set<Int> = []
    
    let onBack: () -> Void

    var body: some View {
        
        HStack(spacing: 16) {
            Button(action: {
                // Handle back action
                onBack()
                
            }) {
                Image("back")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
           
            Text("My ")
                .font(Font(FontManager.font(weight: .semiBold, size: 24)))
            + Text("Tickets")
                .foregroundColor(.blue)
                .font(Font(FontManager.font(weight: .bold, size: 24)))
                .foregroundColor(.primary)
            Spacer()

        }
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
        ScrollView {
            VStack(spacing: 16) {
                // Ticket Card
                VStack(spacing: 12) {
                    Image("qr_logo") // Replace with real QR image
                        .resizable()
                        .frame(width: 150, height: 65)
                        .padding()
                    
                    VStack(spacing: 0.0) {
                        Image("qr") // Replace with real QR image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200, maxHeight: 200)
                            .padding()
                        Text("RBQXCW")
                            .font(Font(FontManager.font(weight: .regular, size: 20)))
                    }
                    .padding(12.0)
                    .background(Color.white)
                   // .cornerRadius(12)
                   
                    
                    Text("SINGLE DAY PASS:")
                        .font(Font(FontManager.font(weight: .semiBold, size: 26)))
                        .foregroundColor(.blue)
                    
                    Text("RESOLVE")
                        .font(Font(FontManager.font(weight: .semiBold, size: 36)))
                        .foregroundColor(.blue)
                       
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(UIColor(hex: "#1B6AD5").withAlphaComponent(0.1)))
              //  .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.blue, lineWidth: 1))
                .padding(.horizontal, 16.0)
                
                HStack(alignment: .top, spacing: 8) {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 2, height: 24) // Adjust height to match text

                    Button(action: {
                        // Handle tap on Ticket Benefits
                    }) {
                        HStack(spacing: 0) {
                            Text("Ticket ")
                                .foregroundColor(.primary)
                            Text("Benefits")
                                .foregroundColor(.blue)
                        }
                        .padding(.leading, 4.0)
                        .font(Font(FontManager.font(weight: .semiBold, size: 20)))
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
                .padding(.leading, 16.0)
            
                // Expandable Event Sections
                VStack(spacing: 10) {
                    ForEach(eventDays) { day in
                        VStack(spacing: 0) {
                            Button(action: {
                                withAnimation {
                                    if expandedDays.contains(day.id) {
                                        expandedDays.remove(day.id)
                                    } else {
                                        expandedDays.insert(day.id)
                                    }
                                }
                            }) {
                                HStack {
                                    Text("Day \(day.id) - \(day.date)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: expandedDays.contains(day.id) ? "chevron.up" : "chevron.down")
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.blue)
                               // .cornerRadius(10)
                            }

                            if expandedDays.contains(day.id) {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(day.events, id: \.self) { event in
                                        HStack(alignment: .top, spacing: 8) {
                                            Image(systemName: "mappin.and.ellipse")
                                                .foregroundColor(.blue)
                                            VStack(alignment: .leading) {
                                                Text(event.name)
                                                    .font(.subheadline)
                                                Text(event.location)
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .padding(.leading, -50.0)
                                    }
                                }
                                .padding(.top, 8)
                            }
                        }
                    }

                }
                .padding(.horizontal, 16.0)
            }
            .padding(.vertical)
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
