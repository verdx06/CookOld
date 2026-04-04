//
//  SearchContentView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 03.04.2026.
//

import SwiftUI

struct SearchContentView: View
{
    var viewModel: SearchViewModel

    var body: some View {
        if case .success(let meals) = viewModel.searchResult {
            if meals.isEmpty {
                EmptyStateView()
            } else {
                MealListView(meals: meals)
                    .transition(.opacity)
            }
        } else {
            CategoriesSection(viewModel: viewModel)
        }
    }
}
