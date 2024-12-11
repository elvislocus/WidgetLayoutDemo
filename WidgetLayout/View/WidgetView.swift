//
//  WidgetView.swift
//  WidgetLayout
//
//  Created by Elvis Lin on 2024/12/10.
//

import SwiftUI

struct WidgetView: View {
    let widget: Widget

    var body: some View {
        RoundedRectangle(cornerRadius: 36)
            .fill(widget.color.swiftUIColor)
            .frame(width: widget.rect.width, height: widget.rect.height)
    }
}
