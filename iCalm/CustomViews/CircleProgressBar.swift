//
//  CircleProgressBar.swift
//  Просто Дыши
//
//  Created by Dmitry Sharygin on 24.04.2023.
//

import SwiftUI

struct CircleProgressBar: View {
    @Binding var progress: Float
    var color = Color.cgCyan
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12.0)
                .opacity(0.15)
                .foregroundColor(color)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .opacity(0.5)
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: self.progress)
        }
    }
}
