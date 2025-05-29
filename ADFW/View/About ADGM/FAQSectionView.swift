//
//  FAQSectionView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import SwiftUICore
import SwiftUI



struct FAQSectionView: View {
    
    let faqItems: [FAQItem]
    @State private var expandedIndex: UUID?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Rectangle() // Vertical blue bar
                    .fill(Color.blue)
                    .frame(width: 3, height: 24)
                    .padding(.trailing, 0)
                Text(" Frequently Asked  ").foregroundColor(Color(UIColor.black))
                    .font(Font(FontManager.font(weight: .semiBold, size: 19))) +
                Text("Questions")
                    .foregroundColor(Color(UIColor.blueColor))
                    .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                    
            }
            .padding(.bottom,8)

            ForEach(faqItems) { item in
                VStack {
                    Button(action: {
                        withAnimation {
                            expandedIndex = expandedIndex == item.id ? nil : item.id
                        }
                    }) {
                        HStack {
                            Text(item.question)
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Image(expandedIndex == item.id ? "upArrow" : "downArrow")  //
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                       
                    }

                    if expandedIndex == item.id {
                        Text(item.answer)
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                           
                            .transition(.opacity)
                    }
                }
              
               
            }
        }
        .padding()
        .padding(.bottom,30)
    }
}
