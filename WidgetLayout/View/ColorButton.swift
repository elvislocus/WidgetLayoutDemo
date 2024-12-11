//
//  ColorButton.swift
//  WidgetLayout
//
//  Created by Elvis Lin on 2024/12/10.
//

import SwiftUI

struct ColorButton: View {
    var color: WidgetColor

    @State private var isDragging = false

    var body: some View {
        Circle()
            .fill(isDragging ? Color.clear : color.swiftUIColor)
            .frame(width: 50, height: 50)
            .contentShape(.dragPreview, Circle())
            .overlay(
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: isDragging ? [5] : []))
                    .foregroundColor(isDragging ? color.swiftUIColor : Color.clear)
            )
            .onDrag(
                {
                    isDragging = true
                    return NSItemProvider(object: color.hexCode as NSString)
                },
                preview: {
                    Circle()
                        .fill(color.swiftUIColor)
                        .frame(width: 50, height: 50)
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 2, y: 2)
                        .contentShape(.dragPreview, Circle())
                }
            )
            .onReceive(NotificationCenter.default.publisher(for: .resetIsDragging)) { _ in
                isDragging = false
            }
    }
}
