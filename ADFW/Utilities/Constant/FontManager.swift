//
//  FontManager.swift
//  EventApp
//
//  Created by MultiTV on 18/02/25.
//


import UIKit

import UIKit

struct FontManager {
    enum FigtreeWeight: Int {
        case light = 300
        case regular = 400
        case medium = 500
        case semiBold = 600
        case bold = 700
       
        var fontName: String {
            switch self {
            case .light: return "IsidoraSans-Light"
            case .regular: return "IsidoraSans-Regular"
            case .medium: return "IsidoraSans-Medium"
            case .semiBold: return "IsidoraSans-SemiBold"
            case .bold: return "IsidoraSans-Bold"
           
                
            }
        }
    }

    static func font(weight: FigtreeWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.fontName, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
}





