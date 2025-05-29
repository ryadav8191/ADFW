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
                .frame(width: 60, height: 60)
               

            VStack(alignment: .leading, spacing: 4) {
                Text(person.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(person.title)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(person.organization)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(
            Color(UIColor(hex: "#F0F2F5"))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}


#Preview {
    PersonCard(person: Person(name: "Rahi", title: "sdfsfs", organization: "fsfsfasfsfs", imageName: "person1"))

}
