//
//  Widget.swift
//  WidgetLayout
//
//  Created by Elvis Lin on 2024/12/10.
//

import Foundation

struct Widget: Identifiable {
    let id = UUID()
    var color: WidgetColor
    var rect: CGRect
}
