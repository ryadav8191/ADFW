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
    @StateObject var viewModel = AboutAdgmsViewModel()
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
                    if let header = viewModel.aboutData {
                        HeaderSectionView(header: header)
                        CardsRowView(cards: header.banner_content ?? [])
                        FAQSectionView(faqItems: header.questions ?? [])
                        EnquirySectionView(enquiry_card: header.contact?.first?.enquiry_card)
                        ContactSectionView(contactInfo: header.contact ?? [], socialMediaIcons: ["linkedin", "insta","twitter","youTube"])
                        
                    }
                    
                    
                  
                }
               
            }
        }
        .onAppear {
            viewModel.fetchAboutAdgms(in: UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .first ?? UIView()) { _ in
                
            }
        }
    }
}
