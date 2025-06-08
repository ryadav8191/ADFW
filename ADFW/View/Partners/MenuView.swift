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
    
    var body: some View {
 //       if #available(iOS 16.0, *) {
 //           NavigationStack {
        VStack (spacing:0){
                
                HStack {
                    Button(action: {
                       // onBack()
                    }) {
                        Image("back")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                    .frame(width: 50,height: 50)
                   // .background(.red)

                    Text("Al Meylas")
                        .font(Font(FontManager.font(weight: .semiBold, size: 19)))
                        .foregroundColor(.primary)

                    Spacer()
                }
             
                Divider()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Image("foodBanner") // Replace with your image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        //  .frame(height: 180)
                        
                        ForEach(sections) { section in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(section.title)
                                    .font(Font(FontManager.font(weight: .semiBold, size: 22)))
                                    .foregroundColor(Color(UIColor.blueColor))
                                    .padding(.horizontal)
                                
                                ForEach(section.items) { item in
                                    VStack(spacing: 4) {
                                        HStack(alignment: .top) {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(item.name)
                                                    .font(Font(FontManager.font(weight: .medium, size: 14.5)))
                                                    .foregroundColor(Color(UIColor.lightBlue))
                                                if !item.description.isEmpty {
                                                    Text(item.description)
                                                        .font(Font(FontManager.font(weight: .medium, size: 12)))
                                                        .foregroundColor(Color(UIColor.lightGray))
                                                }
                                            }
                                            Spacer()
                                            Text(item.price)
                                                .font(Font(FontManager.font(weight: .semiBold, size: 14.5)))
                                                .foregroundColor(Color(UIColor.lightBlue))
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
                    }
                }
//                .navigationBarTitle("Al Meylas", displayMode: .inline)
            }
//        } else {
//            // Fallback on earlier versions
//        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
