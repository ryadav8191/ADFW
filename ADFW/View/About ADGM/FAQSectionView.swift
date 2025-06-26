//
//  FAQSectionView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import SwiftUICore
import SwiftUI
import WebKit

struct FAQSectionView: View {
    let faqItems: [Questions]
    @State private var expandedIndex: Int?
    @State private var dynamicHeights: [CGFloat] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 3, height: 24)
                    .padding(.trailing, 0)

                Group {
                    Text(" Frequently Asked  ")
                        .foregroundColor(Color(UIColor.black)) +
                    Text("Questions")
                        .foregroundColor(Color(UIColor.blueColor))
                }
                .font(Font(FontManager.font(weight: .semiBold, size: 19)))
            }
            .padding(.bottom, 8)

            ForEach(Array(faqItems.enumerated()), id: \.offset) { index, item in
                VStack(alignment: .leading, spacing: 0) {
                    Button(action: {
                        withAnimation {
                            expandedIndex = expandedIndex == index ? nil : index
                        }
                    }) {
                        HStack {
                            Text(item.question ?? "")
                                .font(Font(FontManager.font(weight: .semiBold, size: 15)))
                                .foregroundColor(Color(UIColor.lightBlue))
                            Spacer()
                            Image(expandedIndex == index ? "upArrow" : "downArrow")
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color(UIColor(hex: "#F0F2F5")))
                    }

                    if expandedIndex == index {
                        HTMLWebView(
                            htmlContent: item.answer ?? "",
                            contentHeight: $dynamicHeights[index]
                        )
                        .frame(height: dynamicHeights[index])
                        .padding()
                        .animation(nil)
                        .background(Color.white)
                        .cornerRadius(6)
                    }
                }
            }
        }
        .padding()
        .padding(.bottom, 30)
        .onAppear {
            // Initialize dynamic heights for each item
            dynamicHeights = Array(repeating: 100, count: faqItems.count)
        }
    }
}









struct HTMLWebView: UIViewRepresentable {
    let htmlContent: String
    @Binding var contentHeight: CGFloat

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: HTMLWebView

        init(parent: HTMLWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Evaluate JS to get height of content
            webView.evaluateJavaScript("document.body.scrollHeight") { result, error in
                if let height = result as? CGFloat {
                    DispatchQueue.main.async {
                        self.parent.contentHeight = height
                    }
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        @font-face {
            font-family: 'IsidoraSans-Regular';
            src: local('IsidoraSans-Regular');
        }
        body {
            font-family: 'IsidoraSans-Regular', -apple-system, Helvetica, Arial, sans-serif;
            font-size: 12px;
            color: #555555;
            line-height: 1.5;
            margin: 0;
            padding: 0;
            word-wrap: break-word;
        }
        </style>
        </head>
        <body>
        \(htmlContent)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
}
