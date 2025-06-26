//
//  MenuItem.swift
//  ADFW
//
//  Created by MultiTV on 26/05/25.
//


import SwiftUI

struct FoodMenuItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: String
}

struct SectionData: Identifiable {
    let id = UUID()
    let title: String
    let items: [FoodMenuItem]
}

struct MenuView: View {
    let sections: [SectionData] = [
        SectionData(title: "Savory", items: [
            FoodMenuItem(name: "Bircher Muesli", description: "Hazelnut Dacquoise, Home Made Hazelnut Praline, Caramel Mousse", price: "AED 50"),
            FoodMenuItem(name: "Pistachio Paris Brest", description: "Chocolate Sable, Guanaja Baked Chocolate Ganache, Jivara Whipped Ganache", price: "AED 60"),
            FoodMenuItem(name: "Pistachio Paris Brest", description: "", price: "AED 60"),
            FoodMenuItem(name: "Pistachio Paris Brest", description: "Chocolate Sable, Guanaja Baked Chocolate Ganache, Jivara Whipped Ganache", price: "AED 60"),
            FoodMenuItem(name: "Pistachio Paris Brest", description: "", price: "AED 60"),
            FoodMenuItem(name: "Pistachio Paris Brest", description: "", price: "AED 60")
        ]),
        SectionData(title: "Hot Appetizer", items: [
            FoodMenuItem(name: "Eclipse Caesar Salad", description: "Romaine Leaves, Yuzu Caesar Dressing, Parmesan Cheese, Furikake Croutons (V)", price: "AED 50"),
            FoodMenuItem(name: "Fried Volcano Roll", description: "Lump Crab Meat, Spring Onion and Cucumber Wrapped in Kunafa Dough and Chipotle Mayo", price: "AED 60")
        ])
    ]
    
    @ObservedObject var viewModel: MenuItemsViewModel
    
    var onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Top bar with back button and menu title
            HStack(alignment: .center) {
                Button(action: {
                    onBack()
                }) {
                    Image("back")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                }
                .frame(width: 50, height: 50)
                //.background(Color.red)
                Text(viewModel.menuItems?.name ?? "")
                    .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                    .foregroundColor(Color(UIColor.lightBlue))
                    //.background(Color.blue)
                Spacer()
            }
            
            Divider()
            
            // Content
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack(alignment: .topLeading) {
                        Image("foodBanner")
                            .resizable()
                            .aspectRatio(contentMode: .fit)

                        // Add logo on top of banner image, leading and vertically centered
                        VStack {
                            Spacer()
                            HStack {
                                if let logoUrl = viewModel.menuItems?.image1,
                                   let url = URL(string: logoUrl) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .clipShape(Rectangle()) // Optional: Make logo circular
                                    } placeholder: {
                                        ProgressView()
                                    }
                                } else {
                                    Image("defaultLogo") // fallback image in Assets
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .clipShape(Rectangle())
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding(.leading, 16)
                    }

                    
                    if let menuSections = viewModel.menuItems?.items {
                        ForEach(menuSections, id: \.category_id) { section in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(section.category_name ?? "")
                                    .font(Font(FontManager.font(weight: .semiBold, size: 22)))
                                    .foregroundColor(Color(UIColor.blueColor))
                                    .padding(.horizontal)
                                
                                ForEach(section.items ?? [], id: \.item_id) { item in
                                    VStack(spacing: 4) {
                                        HStack(alignment: .top) {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(item.item_name ?? "")
                                                    .font(Font(FontManager.font(weight: .medium, size: 14.5)))
                                                    .foregroundColor(Color(UIColor.lightBlue))
                                                
                                                if let desc = item.item_description, !desc.isEmpty {
                                                    Text(desc)
                                                        .font(Font(FontManager.font(weight: .medium, size: 12)))
                                                        .foregroundColor(Color(UIColor.lightGray))
                                                }
                                            }
                                            Spacer()
                                            if let price = item.item_price {
                                                Text("QAR \(price)")
                                                    .font(Font(FontManager.font(weight: .semiBold, size: 14.5)))
                                                    .foregroundColor(Color(UIColor.lightBlue))
                                            }
                                        }
                                        
                                        Divider()
                                            .frame(height: 1)
                                            .background(Color(UIColor(hex: "#D4D6D9")))
                                            .padding(.vertical, 16)
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color.white)
                                }
                            }
                        }
                    } else {
                        Text("Loading menu...").padding()
                    }
                }
            }
        }
    }

}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(viewModel: MenuVonBack: <#() -> Void#>)
//    }
//}
