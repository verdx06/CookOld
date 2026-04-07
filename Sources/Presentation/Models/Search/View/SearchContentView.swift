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
    let diContainer: DIContainer

    var body: some View {
        ScrollView {
            switch viewModel.searchResult {
            case .success(let meals):
                if meals.isEmpty {
                    EmptyStateView()
                } else {
                    MealListView(meals: meals, diContainer: diContainer)
                        .transition(.opacity)
                        .refreshable {
                            await viewModel.searchMeals()
                        }
                }
            case .loading where viewModel.searchText.isEmpty == false:
                ScrollView {
                    MealGridPreview()
                }
            case .failure:
                ErrorStateView()
            default:
                CategoriesSection(viewModel: viewModel, diContainer: diContainer)
            }
        }
        .refreshable {
            await viewModel.loadCategories()
        }
    }
}
