//
//  HTMLTextView.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import SwiftUI
import WebKit

struct AttributedText: UIViewRepresentable {
    let htmlContent: String
    @Binding var size: CGSize

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.loadHTMLString(htmlContent, baseURL: nil)

        context.coordinator.observeSize(of: webView, size: $size)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        private var observer: NSKeyValueObservation?

        func observeSize(of webView: WKWebView, size: Binding<CGSize>) {
            observer = webView.scrollView.observe(\.contentSize, options: [.new]) { _, change in
                DispatchQueue.main.async {
                    size.wrappedValue = change.newValue ?? .zero
                }
            }
        }
    }
}
