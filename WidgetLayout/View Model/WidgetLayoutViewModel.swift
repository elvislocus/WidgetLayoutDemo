//
//  WidgetLayoutViewModel.swift
//  WidgetLayout
//
//  Created by Elvis Lin on 2024/12/10.
//

import UIKit
import SwiftUI

final class WidgetLayoutViewModel: ObservableObject {
    @Published var widgets: [Widget] = []
    var canvasFrame: CGRect = .zero

    /// Sort widgets and group them by origin.x, then create a layout
    func groupedWidgetsView() -> some View {
        // Step 1: Sort widgets by origin.x, then origin.y
        let sortedWidgets = widgets.sorted {
            if $0.rect.origin.x == $1.rect.origin.x {
                return $0.rect.origin.y < $1.rect.origin.y
            }
            return $0.rect.origin.x < $1.rect.origin.x
        }

        // Step 2: Group widgets by origin.x
        let groupedByX = Dictionary(grouping: sortedWidgets, by: { $0.rect.origin.x })

        // Step 3: Create VStacks for each group and combine them into an HStack
        return HStack(alignment: .top, spacing: 0) {
            ForEach(groupedByX.keys.sorted(), id: \.self) { xKey in
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(groupedByX[xKey] ?? []) { widget in
                        WidgetView(widget: widget)
                            .frame(width: widget.rect.width, height: widget.rect.height)
                    }
                }
            }
        }
    }

    func addWidget(color: WidgetColor, at location: CGPoint) {
        if let index = widgets.firstIndex(where: { $0.rect.contains(location) }) {
            // Split the existing widget
            let widget = widgets[index]
            let splitResult = splitWidget(widget: widget, at: location)

            // Update the existing widget and add the new widget
            widgets[index] = splitResult.existing
            widgets.append(Widget(color: color, rect: splitResult.new.rect))
        } else {
            // No widget exists at the location, create a full-sized widget
            let width = UIScreen.main.bounds.width - 40
            let newWidget = Widget(color: color, rect: CGRect(origin: .zero, size: CGSize(width: width, height: width)))
            widgets.append(newWidget)
        }
    }

    private func splitWidget(widget: Widget, at location: CGPoint) -> (existing: Widget, new: Widget) {
        var existingRect = widget.rect
        var newRect = widget.rect

        // Determine distances to midpoints
        let midX = widget.rect.midX
        let midY = widget.rect.midY
        let horizontalDistance = abs(location.x - midX)
        let verticalDistance = abs(location.y - midY)

        // Calculate a threshold ratio (to introduce randomness and balance)
        let thresholdRatio: CGFloat = 0.8 // Adjust this value to fine-tune preference

        // Decide the split direction
        if verticalDistance < horizontalDistance * thresholdRatio {
            // Split horizontally (left/right)
            if location.x < midX { // Left
                newRect.size.width = widget.rect.width / 2
                existingRect.origin.x += newRect.width
                existingRect.size.width = widget.rect.width / 2
            } else { // Right
                newRect.origin.x += widget.rect.width / 2
                newRect.size.width = widget.rect.width / 2
                existingRect.size.width = widget.rect.width / 2
            }
        } else {
            // Split vertically (top/bottom)
            if location.y < midY { // Top
                newRect.size.height = widget.rect.height / 2
                existingRect.origin.y += newRect.height
                existingRect.size.height = widget.rect.height / 2
            } else { // Bottom
                newRect.origin.y += widget.rect.height / 2
                newRect.size.height = widget.rect.height / 2
                existingRect.size.height = widget.rect.height / 2
            }
        }

        // Return the updated existing widget and the new widget
        return (
            existing: Widget(color: widget.color, rect: existingRect),
            new: Widget(color: widget.color, rect: newRect)
        )
    }
}
