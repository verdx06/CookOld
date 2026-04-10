//
//  PreviewRectangle.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 02.04.2026.
//

import SwiftUI

struct PreviewRectangle: View
{
    var cornerRadius: CGFloat = 12

    @State private var isAnimating = false

    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(Color(.systemGray5))
                .overlay(alignment: .leading) {
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0),
                            .init(color: Color(.systemGray3).opacity(0.7), location: 0.5),
                            .init(color: .clear, location: 1)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geo.size.width * 0.5)
                    .offset(x: isAnimating ? geo.size.width * 1.5 : -geo.size.width * 0.5)
                    .animation(
                        .linear(duration: 1.2).repeatForever(autoreverses: false),
                        value: isAnimating
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .onAppear { isAnimating = true }
    }
}
