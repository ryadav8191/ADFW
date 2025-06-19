//
//  SessionOverviewView.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import SwiftUICore
import SwiftUI


struct SessionOverviewView: View {
     var session: Session?
    @State private var isFavorite = false
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
           
            Text("Session ") ///Session overview
                .font(Font(FontManager.font(weight: .semiBold, size: 19)))
            + Text("Overview")
                .font(Font(FontManager.font(weight: .bold, size: 19)))
                .foregroundColor(Color(UIColor.blueColor))
            Spacer()

        }
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
      //  NavigationView {
            ScrollView {
                if let session = session {
                    VStack(alignment: .leading, spacing: 16) {

                        // Date and Favorite
                        VStack {
                            HStack {
                                Text(session.date)
                                    .font(Font(FontManager.font(weight: .bold, size: 18)))
                                    .foregroundColor(Color(UIColor.blueColor))
                                Spacer()
                            }
                            
                            HStack {
                                Text("2026")
                                    .font(Font(FontManager.font(weight: .semiBold, size: 16)))
                                    .foregroundColor(Color.black)
                                Rectangle()
                                    .background(Color.black)
                                    .frame(height: 1)
                            }
                            
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
                        if let url = URL(string: session.bannerImage) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView() // Loading indicator
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                case .failure:
                                    Image(systemName: "photo") // Fallback image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }


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
                            + Text("Speaker")
                                
                                .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                                .foregroundColor(Color(UIColor.blueColor))

                            ForEach(session.speakers) { person in
                                PersonCard(person: person)
                            }
                        }

                        // Moderators
                        if let  data = session.moderators {
                            Text("Moderator")
                                .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                                .foregroundColor(Color(UIColor.blueColor))

//                            ForEach(session.moderators) { person in
                            PersonCard(person: data)
//                            }
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
    SessionOverviewView(onBack: {})
}
