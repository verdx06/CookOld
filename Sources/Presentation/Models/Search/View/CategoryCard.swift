//
//  CategoryCard.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct CategoryCard: View {
    let category: MealCategory
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: category.image)) { phase in
                switch phase {
                case .empty:
                    PreviewRectangle()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                case .failure:
                    Color(.systemGray5)
                @unknown default:
                    Color(.systemGray5)
                }
            }
            
            
            LinearGradient(
                colors: [.clear, .black.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
            
            Text(category.name)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(10)
        }
        .frame(height: 120)
        .clipped()
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}
