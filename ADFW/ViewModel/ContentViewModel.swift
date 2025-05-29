//
//  ContentViewModel.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import Combine
import Foundation


// MARK: - ViewModel

class ContentViewModel: ObservableObject {
    @Published var headerInfo: HeaderInfo?
    @Published var cards: [CardInfo] = []
    @Published var faqItems: [FAQItem] = []
    @Published var contactInfo: ContactInfo?

    init() {
        fetchData()
    }

    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.headerInfo = HeaderInfo(
                imageURL: URL(string: "https://fastly.picsum.photos/id/1003/200/200.jpg?hmac=w2SN03yog7_RB-IfnyWX1FtBjSHebnoWD35Lj4-iV7o")!,
                title: "World’s Definitive International",
                subtitle: "Financial Center In The Capital Of the UAE",
                description: "The United Arab Emirates has become a leading centre for innovation in finance attracting global corporations and investment banks, fintech, private equity and venture capitalists, asset managers and advisory firms, thanks to its robust, vibrant, and diverse business environment, and exceptional lifestyle opportunities.Abu Dhabi is home to some of the world's largest sovereign wealth funds and provides strong access to capital through substantial private wealth and several catalyst partners. With its tax-friendly environment and unique connectivity to east and west markets, combined with exceptional healthcare, leading educational institutions and world-class lifestyle activities, Abu Dhabi is ranked as the most liveable city in the region."
            )
            self.cards = [
                CardInfo(imageURL: URL(string: "https://fastly.picsum.photos/id/1003/200/200.jpg?hmac=w2SN03yog7_RB-IfnyWX1FtBjSHebnoWD35Lj4-iV7o")!, title: "Business Areas", description: "Learn more about what ADGM has to offer, from easy set-up processes on an enabling infrastructure to a variety of office spaces."),
                CardInfo(imageURL: URL(string: "https://fastly.picsum.photos/id/1003/200/200.jpg?hmac=w2SN03yog7_RB-IfnyWX1FtBjSHebnoWD35Lj4-iV7o")!, title: "Setting up in ADGM", description: "Learn more about what ADGM has to offer, from easy set-up processes on an enabling infrastructure to a variety of office spaces.")
            ]
            self.faqItems = [
                FAQItem(question: "How to use a ticket in ADGM?", answer: """
                        To find a hotel location in the ADGM mobile app, follow these steps:
                        
                        1. Open the App: Launch the ADGM mobile app on your device.

                        2. Log In: Enter your credentials if you are not already logged in.

                        3. Navigate to the Hotel Section: Look for a section labeled “Hotels,” “Accommodations,” or something similar in the main menu or dashboard.

                        4. Search for Hotels: Use the search feature to find the hotel you're interested in. You may be able to search by name or browse through a list of hotels.

                        5. View Hotel Details: Select the hotel you want to see. This should provide you with detailed information, including the location.

                        6. Find Location: Look for a map or location section within the hotel details. This will show you the hotel’s address and possibly provide directions or a map view.

                        7. Get Directions: If available, use the app’s built-in feature to get directions to the hotel from your current location.

                        If you have trouble finding the hotel location or if the app does not provide this feature, you may also consider contacting the hotel directly for directions or visiting their website for more information.
                        """),
                FAQItem(question: "How to find the hotel location on map?",
                        answer: """
                        To find a hotel location in the ADGM mobile app, follow these steps:
                
                        1. Open the App: Launch the ADGM mobile app on your device.

                        2. Log In: Enter your credentials if you are not already logged in.

                        3. Navigate to the Hotel Section: Look for a section labeled “Hotels,” “Accommodations,” or something similar in the main menu or dashboard.

                        4. Search for Hotels: Use the search feature to find the hotel you're interested in. You may be able to search by name or browse through a list of hotels.

                        5. View Hotel Details: Select the hotel you want to see. This should provide you with detailed information, including the location.

                        6. Find Location: Look for a map or location section within the hotel details. This will show you the hotel’s address and possibly provide directions or a map view.

                        7. Get Directions: If available, use the app’s built-in feature to get directions to the hotel from your current location.

                        If you have trouble finding the hotel location or if the app does not provide this feature, you may also consider contacting the hotel directly for directions or visiting their website for more information.
            
            """)
            ]
            self.contactInfo = ContactInfo(
                address: "ADGM Square, Al Maryah Island, Abu Dhabi, UAE",
                hours: [
                    ContactHour(day: "Monday to Thursday", time: "9:00 AM to 5:00 PM"),
                    ContactHour(day: "Friday", time: "9:00 AM to 1:00 PM")
                ],
                socialMediaLinks: [
                    URL(string: "https://linkedin.com")!,
                    URL(string: "https://x.com")!,
                    URL(string: "https://x.com")!,
                    URL(string: "https://x.com")!
                ]
            )
        }
    }
}
