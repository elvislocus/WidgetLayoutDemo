//
//  ColorPaletteView.swift
//  WidgetLayout
//
//  Created by Elvis Lin on 2024/12/10.
//

import SwiftUI

struct ColorPaletteView: View {
    var body: some View {
        HStack(spacing: 20) {
            ColorButton(color: .skyBlue)
            ColorButton(color: .hotPink)
            ColorButton(color: .brightYellow)
            ColorButton(color: .limeGreen)
            ColorButton(color: .vibrantOrange)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            Capsule()
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
    }
}

#Preview {
    ColorPaletteView()
}
