//
//  MealListView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 02.04.2026.
//

import SwiftUI

struct MealListView: View
{
    let meals: [Meal]
    @Environment(\.favoriteViewModel) private var favoriteViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(meals, id: \.idMeal) { meal in
                    let stamped = favoriteViewModel.stamped(meal)
                    CardDishView(meal: stamped) {
                        favoriteViewModel.toggleLike(meal)
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
                .animation(.spring(duration: 0.4), value: meals.count)
            }
            .padding(.horizontal)
        }
    }
}
