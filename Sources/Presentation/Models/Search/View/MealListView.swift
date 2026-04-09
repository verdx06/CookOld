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
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(meals, id: \.idMeal) { meal in
                        NavigationLink {
                            DetailView(viewModel: viewModel.detailViewModel(for: meal.idMeal))
                        } label: {
                            CardDishView(
                                title: meal.strMeal,
                                image: meal.imageURL,
                                category: meal.strCategory ?? "",
                                area: meal.strArea ?? "",
                                isFavorite: false,
                                onFavoriteTap: {}
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
