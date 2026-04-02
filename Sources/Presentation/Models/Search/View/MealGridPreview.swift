//
//  MealGridPreview.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 02.04.2026.
//

import SwiftUI

struct MealGridPreview: View {
    var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(0..<10, id: \.self) { _ in
                PreviewRectangle()
                    .frame(height: 160)
            }
        }
        .padding(.horizontal)
    }
    
}
