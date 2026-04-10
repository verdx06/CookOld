//
//  MealListView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 02.04.2026.
//

import SwiftUI

struct MealListView: View
{
    var viewModel: MealListProviding
    let meals: [Meal]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(meals, id: \.idMeal) { meal in
                    NavigationLink {
                        DetailView(viewModel: viewModel.detailViewModel(for: meal.idMeal))
                    } label: {
                        CardDishView(meal: meal) {}
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
            }
        }
    }
}
