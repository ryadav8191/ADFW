//
//  SessionOverviewView.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import SwiftUICore
import SwiftUI


struct SessionOverviewView: View {
    @StateObject private var viewModel = SessionViewModel()
    @State private var isFavorite = false

    var body: some View {
        
        HStack(spacing: 16) {
            Button(action: {
                // Handle back action
                
                
            }) {
                Image("back")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
           
            Text("Session ") ///Session overview
                .font(Font(FontManager.font(weight: .semiBold, size: 24)))
            + Text("Overview")
                .foregroundColor(.blue)
                .font(Font(FontManager.font(weight: .bold, size: 24)))
                .foregroundColor(Color(UIColor.blueColor))
            Spacer()

        }
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
      //  NavigationView {
            ScrollView {
                if let session = viewModel.session {
                    VStack(alignment: .leading, spacing: 16) {

                        // Date and Favorite
                        HStack {
                            Text(session.date)
                                .font(Font(FontManager.font(weight: .bold, size: 18)))
                                .foregroundColor(Color(UIColor.blueColor))
                            Spacer()
                        }
                        
                        HStack {
                            Spacer() // Pushes button to the right

                            Button(action: {
                                isFavorite.toggle()
                            }) {
                                HStack(spacing: 4) {
                                    Text("Add to favourite")
                                        .font(Font(FontManager.font(weight: .medium, size: 13)))
                                        .foregroundColor(Color(UIColor(hex: "#A3A6A7")))
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(isFavorite ? .red : .gray)
                                }
                                
                            }
                            .buttonStyle(PlainButtonStyle()) // Prevents large tap area
                        }
                        .padding(.horizontal)


                        // Banner Image
                        Image(session.bannerImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                           

                        // Time and Location
                        HStack(spacing: 12) {
                            // Time Box
                            HStack(spacing: 4) {
                                Image("clock")
                                    .frame(width: 10,height: 10)
                                Text(session.time)
                                    .font(Font(FontManager.font(weight: .medium, size: 13)))
                                    .foregroundColor(Color(UIColor(hex: "#002646")))
                            }
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.gray, lineWidth: 1)
                            )

                            // Location Box
                            HStack(spacing: 4) {
                                Image("geo-alt")
                                    .frame(width: 10,height: 10)
                                Text(session.location)
                                    .font(Font(FontManager.font(weight: .medium, size: 13)))
                                    .foregroundColor(Color(UIColor(hex: "#002646")))
                            }
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        }


                        // Session Title
                        Text(session.title)
                            .font(Font(FontManager.font(weight: .semiBold, size: 18)))
                            .foregroundColor(Color(UIColor(hex: "#002646")))

                        // Description
                        Text(session.description)
                            .font(Font(FontManager.font(weight: .medium, size: 14)))
                            .foregroundColor(Color(UIColor(hex: "#002646")))

                        Divider()

                        // Speakers
                        if !session.speakers.isEmpty {
                            Text("Session ") ///Session overview
                                .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                            + Text("Overview")
                                
                                .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                                .foregroundColor(Color(UIColor.blueColor))

                            ForEach(session.speakers) { person in
                                PersonCard(person: person)
                            }
                        }

                        // Moderators
                        if !session.moderators.isEmpty {
                            Text("Moderator")
                                .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                                .foregroundColor(Color(UIColor.blueColor))

                            ForEach(session.moderators) { person in
                                PersonCard(person: person)
                            }
                        }
                    }
                    .padding()
                } else {
                    ProgressView("Loading...")
                }
            }
            .background(Color(UIColor(hex: "#F5F5F5")))
          //  .navigationTitle("Session Overview")
      //  }
    }
    
}


#Preview {
    SessionOverviewView()
}
