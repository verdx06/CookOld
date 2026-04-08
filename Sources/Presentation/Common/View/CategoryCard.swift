//
//  CategoryCard.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct CategoryCard: View
{
    let category: MealCategory

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {
                LoadableImage(url: category.image)
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()

                LinearGradient(
                    colors: [.clear, .clear, .black.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                Text(category.name)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .lineLimit(2)
                    .foregroundStyle(.white)
                    .padding(10)
            }
        }
        .frame(height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
    }
}
