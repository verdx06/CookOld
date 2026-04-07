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

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(meals, id: \.idMeal) { meal in
                    CardDishView(
                        title: meal.strMeal,
                        image: meal.strMealThumb,
                        category: meal.strCategory ?? "",
                        area: meal.strArea ?? "",
                        isFavorite: false) {}
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
                .animation(.spring(duration: 0.4), value: meals.count)
            }
            .padding(.horizontal)
        }
    }
}
