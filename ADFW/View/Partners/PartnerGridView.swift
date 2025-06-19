//
//  PartnerViewModels.swift
//  ADFW
//
//  Created by MultiTV on 17/06/25.
//


import SwiftUI
import Combine

struct PartnerGridView: View {
    @ObservedObject var viewModel: PartnerGridViewModel

    let columns2 = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                // Handle back action
                
                onBack()
                
            }) {
                Image("back")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
           
            Text("Our ") ///Session overview
                .font(Font(FontManager.font(weight: .semiBold, size: 19)))
            + Text("Partners")
                .font(Font(FontManager.font(weight: .bold, size: 19)))
                .foregroundColor(Color(UIColor.blueColor))
            Spacer()

        }
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
        
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(viewModel.partnerSections, id: \.title) { section in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(section.title)
                            .font(Font(FontManager.font(weight: .semiBold, size: 18)))
                            .foregroundColor(Color(UIColor.blueColor))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal)

                        let logos = section.logos

                        if logos.count == 1 {
                            singleLogo(logos.first!)
                        } else if logos.count % 2 == 1 {
                            // Odd count: Grid for all but last
                            LazyVGrid(columns: columns2, spacing: 16) {
                                ForEach(logos.dropLast(), id: \.self) { logo in
                                    LogoCardView(url: logo) { isValid in
                                        if !isValid {
                                            removeInvalidLogo(logo, from: section.title)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)

                            // Center last one
                            if let lastLogo = logos.last {
                                HStack {
                                    Spacer()
                                    LogoCardView(url: lastLogo) { isValid in
                                        if !isValid {
                                            removeInvalidLogo(lastLogo, from: section.title)
                                        }
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            // Even count: full grid
                            LazyVGrid(columns: columns2, spacing: 16) {
                                ForEach(logos, id: \.self) { logo in
                                    LogoCardView(url: logo) { isValid in
                                        if !isValid {
                                            removeInvalidLogo(logo, from: section.title)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }

    @ViewBuilder
    func singleLogo(_ url: String) -> some View {
        HStack {
            Spacer()
            LogoCardView(url: url) { isValid in
                if !isValid {
                    removeInvalidLogo(url, from: viewModel.partnerSections.first { $0.logos.contains(url) }?.title ?? "")
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }

    func removeInvalidLogo(_ logo: String, from sectionTitle: String) {
        DispatchQueue.main.async {
            if let index = viewModel.partnerSections.firstIndex(where: { $0.title == sectionTitle }) {
                viewModel.partnerSections[index].logos.removeAll(where: { $0 == logo })
            }
        }
    }
}



struct LogoCardView: View {
    let url: String
    var onLoadResult: (Bool) -> Void

    @StateObject private var loader = ImageLoader()

    var body: some View {
        ZStack {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding()
                    .onAppear {
                        onLoadResult(true)
                    }
            } else {
                ProgressView()
                    .frame(height: 80)
            }
        }
        .onAppear {
            loader.load(from: url)
        }
        .onDisappear {
            loader.cancel()
        }
        .background(Color.white)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}





class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private var cancellable: AnyCancellable?

    func load(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("image/*", forHTTPHeaderField: "Accept")
        request.setValue("Mozilla/5.0", forHTTPHeaderField: "User-Agent")

        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .sink { [weak self] in self?.image = $0 }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
