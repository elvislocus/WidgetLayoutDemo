//
//  WidgetColor.swift
//  WidgetLayout
//
//  Created by Elvis Lin on 2024/12/10.
//

import SwiftUI

enum WidgetColor: CaseIterable {
    case skyBlue
    case hotPink
    case brightYellow
    case limeGreen
    case vibrantOrange

    var hexCode: String {
        switch self {
        case .skyBlue: return "#00CFFF"
        case .hotPink: return "#FF5C93"
        case .brightYellow: return "#FFEB3B"
        case .limeGreen: return "#AEEA00"
        case .vibrantOrange: return "#FF6D00"
        }
    }

    var swiftUIColor: Color {
        return Color(hex: self.hexCode)
    }

    init?(hex: String) {
        guard let matchingColor = WidgetColor.allCases.first(where: { $0.hexCode.uppercased() == hex.uppercased() }) else {
            return nil
        }
        self = matchingColor
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
