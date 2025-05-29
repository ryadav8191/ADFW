//
//  MainView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import SwiftUICore
import SwiftUI


// MARK: - Views

struct MainView: View {
    @StateObject var viewModel = ContentViewModel()
    let onBack: () -> Void

    var body: some View {
        
        VStack {
            HStack {
                Button(action: {
                    // Handle back action
                    onBack()
                    
                }) {
                    Image("back")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                }
                
                Text("About ADGM")
                    .font(Font(FontManager.font(weight: .semiBold, size: 19)))
//                    .underline(true, color: Color.blue.opacity(0.7))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding()
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if let header = viewModel.headerInfo {
                        HeaderSectionView(header: header)
                    }
                    CardsRowView(cards: viewModel.cards)
                    FAQSectionView(faqItems: viewModel.faqItems)
                    EnquirySectionView()
                    if let contact = viewModel.contactInfo {
                        ContactSectionView(contactInfo: contact, socialMediaIcons: ["linkedin", "insta","twitter","youTube"])
                    }
                }
               
            }
        }
    }
}
