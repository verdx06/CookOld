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
        switch viewModel.searchResult {
        case .success(let meals):
            if meals.isEmpty {
                EmptyStateView()
            } else {
                MealListView(meals: meals)
                    .transition(.opacity)
                    .refreshable {
                        await viewModel.searchMeals()
                    }
            }
        case .loading where viewModel.searchText.isEmpty == false:
            ScrollView {
                MealGridPreview()
            }
        default:
            CategoriesSection(viewModel: viewModel)
        }
    }
}
