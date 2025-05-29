//
//  CalendarPopupView.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//

import SwiftUICore
import SwiftUI

struct CalendarPopupView: View {
    @Binding var selectedDate: String
    @Binding var isPresented: Bool

    let dates = ["09 DECEMBER", "10 DECEMBER", "11 DECEMBER", "12 DECEMBER","88 DECEMBER","66 DECEMBER"]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(spacing: 0) {
            // Title Bar
            Text("ADFW Week")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#002B4E"))

            // Grid of date buttons
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(dates, id: \.self) { date in
                    calendarButton(for: date)
                }
            }
            .padding(20)
            .background(Color.white)
        }
        .frame(width: 350)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 20)
    }

    // Separate view builder to reduce complexity
    @ViewBuilder
    private func calendarButton(for date: String) -> some View {
        let isSelected = date == selectedDate
        let bgColor = isSelected ? Color(hex: "#0C60D4") : Color.white
        let textColor = isSelected ? Color.white : Color(hex: "#0C60D4")
        let borderColor = Color(hex: "#0C60D4")

        Button(action: {
            selectedDate = date
            isPresented = false
        }) {
            Text(date)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, minHeight: 70)
                .background(bgColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(borderColor, lineWidth: 1)
                )
                .cornerRadius(2)
        }
    }
}


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}


class OverlayPresenter {
    static func showFilterOverlay() {
        guard let rootView = UIApplication.shared.connectedScenes
                .compactMap({ ($0 as? UIWindowScene)?.keyWindow?.rootViewController?.view })
                .first else {
            return
        }

        let overlay = FilterOverlayView(frame: rootView.bounds)
        overlay.alpha = 0
        // Optional: set delegate if needed
        // overlay.delegate = yourDelegate if applicable
        rootView.addSubview(overlay)

        UIView.animate(withDuration: 0.3) {
            overlay.alpha = 1
        }
    }
}
