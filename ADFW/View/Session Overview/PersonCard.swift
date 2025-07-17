//
//  PersonCard.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import SwiftUICore
import SwiftUI

struct PersonCard: View {
    let person: Speaker
    let onTap: ((Speaker) -> Void)?
    var body: some View {
        HStack(spacing: 12) {
//            Image(person.imageName)
//                .resizable()
//                .frame(width: 72, height: 72)
            
            if let url = URL(string: person.imageUrl ?? "") {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Loading indicator
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 72, height: 72)
                            .cornerRadius(3)
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

            VStack(alignment: .leading, spacing: 4) {
                Text(person.name)
                    .font(Font(FontManager.font(weight: .semiBold, size: 14)))
                Text(person.role)
                    .font(Font(FontManager.font(weight: .medium, size: 13)))
                    .foregroundColor(.gray)
                Text(person.companyName ?? "")
                    .font(Font(FontManager.font(weight: .medium, size: 13)))
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .onTapGesture {
            onTap?(person)
        }
        .background(
            Color.white
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .cornerRadius(3)
    }
}


#Preview {
  
}
