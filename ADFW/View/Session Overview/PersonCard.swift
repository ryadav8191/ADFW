//
//  PersonCard.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import SwiftUICore
import SwiftUI

struct PersonCard: View {
    let person: Person

    var body: some View {
        HStack(spacing: 12) {
            Image(person.imageName)
                .resizable()
                .frame(width: 72, height: 72)
               

            VStack(alignment: .leading, spacing: 4) {
                Text(person.name)
                    .font(Font(FontManager.font(weight: .semiBold, size: 14)))
                Text(person.title)
                    .font(Font(FontManager.font(weight: .medium, size: 13)))
                    .foregroundColor(.gray)
                Text(person.organization)
                    .font(Font(FontManager.font(weight: .medium, size: 13)))
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(
            Color.white
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}


#Preview {
    PersonCard(person: Person(name: "Rahi", title: "sdfsfs", organization: "fsfsfasfsfs", imageName: "person1"))

}
