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
                    Text(meal.strMeal)
                    // TODO: карточка блюда
                }
            }
            .padding(.horizontal)
        }
    }
}
