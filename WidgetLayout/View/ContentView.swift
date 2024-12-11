//
//  ContentView.swift
//  WidgetLayout
//
//  Created by Elvis Lin on 2024/12/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WidgetLayoutViewModel()

    var body: some View {
        VStack {
            canvasView
                .dropDestination(for: String.self) { items, location in
                    if let hex = items.first, let widgetColor = WidgetColor(hex: hex) {
                        let canvasLocation = CGPoint(
                            x: location.x - viewModel.canvasFrame.origin.x,
                            y: location.y - viewModel.canvasFrame.origin.y
                        )
                        viewModel.addWidget(color: widgetColor, at: canvasLocation)
                        NotificationCenter.default.post(name: .resetIsDragging, object: nil)
                        return true
                    }
                    return false
                }

            ColorPaletteView()
                .padding(.bottom, 30)
        }
    }

    @ViewBuilder
    private var canvasView: some View {
        if viewModel.widgets.isEmpty {
            initialBackground
        } else {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    viewModel.groupedWidgetsView()
                    Spacer()
                }
                Spacer()
            }
        }
    }

    @ViewBuilder
    private var initialBackground: some View {
        GeometryReader { geometry in
            let squareSize = geometry.size.width - 40
            VStack {
                Spacer()
                VStack {
                    Image(systemName: "hands.sparkles.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)

                    Text("Hi!\nDrag and drop your widget to unleash \nyour creativity!")
                        .font(.headline)
                }
                .padding()
                .frame(width: squareSize, height: squareSize)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                )
                .background(GeometryReader { geometry in
                    Color.white.preference(key: CanvasFrameKey.self, value: geometry.frame(in: .global))
                })
                .onPreferenceChange(CanvasFrameKey.self) { frame in
                    viewModel.canvasFrame = frame
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            .foregroundStyle(Color.gray)
        }
    }
}

#Preview {
    ContentView()
}
