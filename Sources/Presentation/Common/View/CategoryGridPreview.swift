//
//  PreviewRectangleView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 02.04.2026.
//

import SwiftUI

struct CategoryGridPreview: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 12) {
            ForEach(0..<10, id: \.self) { _ in
                PreviewRectangle()
                    .frame(height: 120)
            }
        }
        .padding(.horizontal)
    }
}

