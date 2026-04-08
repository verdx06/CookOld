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
        RoundedRectangle(cornerRadius: self.cornerRadius, style: .continuous)
            .fill(Color(.systemGray5))
            .opacity(isAnimating ? 0.4 : 1.0)
            .animation(
                .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear { isAnimating = true }
    }
}
