//
//  InterestView.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//


import SwiftUI

struct InterestSelectionView: View {
    @State private var selectedCategories: Set<String> = ["Blockchain & Ai", "Setting Up In ADGM"]
    @State private var isNetworkingOpen = false

    let categories = [
        "Regulation", "Asset Management", "Fintech", "Blockchain & Ai",
        "Economy Forum", "Event - B", "Setting Up In ADGM", "Event - C",
        "Event - D", "Sustainable Finance", "Roundtable Meeting"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Title
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Categories")
                            .font(.headline)
                            .foregroundColor(.blue)

                        Text("Set your interest by choosing few categories from below based on your interest to get started.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    // Chips
                    FlexibleView(
                        data: categories,
                        spacing: 10,
                        alignment: .leading
                    ) { category in
                        Button(action: {
                            if selectedCategories.contains(category) {
                                selectedCategories.remove(category)
                            } else {
                                selectedCategories.insert(category)
                            }
                        }) {
                            Text(category)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(selectedCategories.contains(category) ? Color.blue : Color.white)
                                .foregroundColor(selectedCategories.contains(category) ? .white : .blue)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue, lineWidth: 1)
                                )
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)

                    // Toggle Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Message")
                            .font(.headline)

                        HStack {
                            Text("Open to networking")
                            Spacer()
                            Toggle("", isOn: $isNetworkingOpen)
                                .labelsHidden()
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    Spacer()

                    // Save Button
                    Button(action: {
                        // Save action here
                    }) {
                        HStack {
                            Spacer()
                            Text("SAVE")
                                .foregroundColor(.white)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationBarTitle("Interests", displayMode: .inline)
        }
    }
}



struct WrapView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    var data: Data
    var spacing: CGFloat
    var content: (Data.Element) -> Content
    
    init(data: Data, spacing: CGFloat = 8, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(data, id: \.self) { item in
                    content(item)
                        .padding(.horizontal, 4)
                        .alignmentGuide(.leading, computeValue: { dimension in
                            if abs(width - dimension.width) > geometry.size.width {
                                width = 0
                                height -= dimension.height + spacing
                            }
                            let result = width
                            if item == data.last {
                                width = 0
                            } else {
                                width -= dimension.width + spacing
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: { _ in height })
                }
            }
        }
        .frame(height: 200) // Adjust height as needed
    }
}

struct InterestsView_Previews: PreviewProvider {
    static var previews: some View {
        InterestSelectionView()
    }
}
















//
//import SwiftUI
//
//struct InterestSelectionView: View {
//    @State private var selectedCategories: Set<String> = ["Blockchain & Ai", "Setting Up In ADGM"]
//    @State private var isNetworkingOpen = false
//
//    let categories = [
//        "Regulation", "Asset Management", "Fintech", "Blockchain & Ai",
//        "Economy Forum", "Event - B", "Setting Up In ADGM", "Event - C",
//        "Event - D", "Sustainable Finance", "Roundtable Meeting"
//    ]
//    
//    let columns = [
//        GridItem(.flexible(), spacing: 10),
//        GridItem(.flexible(), spacing: 10)
//    ]
//
//    var body: some View {
//        HStack {
//            Button(action: {
//                // Handle back action
//            
//            }) {
//                Image("back")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 18, height: 18)
//            }
//            
//            Text("Interests")
//                .font(Font(FontManager.font(weight: .semiBold, size: 19))
//                )
//                .foregroundColor(.primary)
//        }
//        .padding()
//        
//        Divider()
//        
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                // Categories
//                Text("Categories")
//                    .font(.headline)
//                    .padding(.horizontal)
//                
//                Text("Set your interest by choosing few categories from below based on your interest to get started.")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .padding(.horizontal)
//                
//                LazyVGrid(columns: columns, spacing: 12) {
//                    ForEach(categories, id: \.self) { category in
//                        Button(action: {
//                            if selectedCategories.contains(category) {
//                                selectedCategories.remove(category)
//                            } else {
//                                selectedCategories.insert(category)
//                            }
//                        }) {
//                            Text(category)
//                                .padding(.vertical, 8)
//                                .padding(.horizontal, 12)
//                                .frame(maxWidth: .infinity)
//                                .background(selectedCategories.contains(category) ? Color.blue : Color.white)
//                                .foregroundColor(selectedCategories.contains(category) ? .white : .blue)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(Color.blue, lineWidth: 1)
//                                )
//                                .cornerRadius(8)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//               
//                
//                // Networking Toggle
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Message")
//                        .font(.headline)
//                    
//                    HStack {
//                        Text("Open to networking")
//                        Spacer()
//                        Toggle("", isOn: $isNetworkingOpen)
//                            .labelsHidden()
//                    }
//                }
//                .padding()
//                .background(Color(UIColor.white))
//                .cornerRadius(10)
//                .padding(.horizontal)
//                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
//                
//                Spacer()
//                
//                // Save Button
//                Button(action: {
//                    // Save action
//                }) {
//                    HStack {
//                        Spacer()
//                        Text("SAVE")
//                            .foregroundColor(.white)
//                        Image(systemName: "arrow.right")
//                            .foregroundColor(.white)
//                        Spacer()
//                    }
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top)
//            
//        }
//        
//        
//    }
//}
//
//
//#Preview {
//    InterestSelectionView()
//}



//import SwiftUI
//
//struct InterestView: View {
//    @Environment(\.presentationMode) var presentationMode
//
//    @State private var selectedCategories: Set<String> = ["Blockchain & Ai", "Setting Up In ADGM"]
//    @State private var isOpenToNetworking = false
//
//    let categories = [
//        "Regulation", "Asset Management", "Fintech", "Blockchain & Ai",
//        "Economy Forum", "Event - B", "Setting Up In ADGM", "Event - C",
//        "Event - D", "Sustainable Finance", "Roundtable Meeting"
//    ]
//
//    var body: some View {
//        VStack {
//            // Top Bar
//            HStack {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(.gray)
//                }
//                Text("Interests")
//                    .font(.system(size: 18, weight: .semibold))
//                    .padding(.leading, 8)
//                Spacer()
//            }
//            .padding()
//
//            ScrollView {
//                VStack(alignment: .leading, spacing: 24) {
//                    // Categories Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Categories")
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundColor(Color(hex: "#2566AF"))
//
//                        Text("Set your interest by choosing few categories from below based on your interest to get started.")
//                            .font(.system(size: 13))
//                            .foregroundColor(.gray)
//
//                        // Tags Grid
//                        FlexibleView(data: categories, spacing: 10, alignment: .leading) { category in
//                            let isSelected = selectedCategories.contains(category)
//                            Text(category)
//                                .font(.system(size: 14))
//                                .padding(.horizontal, 12)
//                                .padding(.vertical, 8)
//                                .background(isSelected ? Color(hex: "#2566AF") : .white)
//                                .foregroundColor(isSelected ? .white : Color(hex: "#2566AF"))
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .stroke(Color(hex: "#2566AF"), lineWidth: 1)
//                                )
//                                .cornerRadius(20)
//                                .onTapGesture {
//                                    if isSelected {
//                                        selectedCategories.remove(category)
//                                    } else {
//                                        selectedCategories.insert(category)
//                                    }
//                                }
//                        }
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(12)
//                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
//
//                    // Toggle Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Message")
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundColor(Color(hex: "#2566AF"))
//
//                        HStack {
//                            Text("Open to networking")
//                                .font(.system(size: 14))
//                                .foregroundColor(.gray)
//                            Spacer()
//                            Toggle("", isOn: $isOpenToNetworking)
//                                .labelsHidden()
//                        }
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(12)
//                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
//
//                    Spacer().frame(height: 100) // Space for button
//                }
//                .padding()
//            }
//
//            // Save Button
//            VStack {
//                Button(action: {
//                    print("Save tapped")
//                }) {
//                    HStack {
//                        Spacer()
//                        Text("SAVE")
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundColor(.white)
//                        Image(systemName: "arrow.right")
//                            .foregroundColor(.white)
//                        Spacer()
//                    }
//                    .padding()
//                    .background(Color(hex: "#2566AF"))
//                    .cornerRadius(10)
//                }
//                .padding(.horizontal)
//            }
//            .padding(.bottom)
//            .background(Color.white)
//        }
//        .background(Color(hex: "#F3F3F3").ignoresSafeArea())
//    }
//}
