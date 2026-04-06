//
//  CategoryFilterView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct CategoryFilterView: View
{
    @State private var viewModel: CategoryViewModel

    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            SearchBar(searchText: $viewModel.searchText, onSearch: {
                Task { await viewModel.searchMealsInCategory() }
            })
            .padding()

            switch viewModel.searchResult {
            case .idle, .loading:
                preview
            case .success(let meals):
                if meals.isEmpty {
                    EmptyStateView()
                } else {
                    MealListView(meals: meals)
                        .refreshable {
                            await viewModel.searchMealsInCategory()
                        }
                }
            case .failure:
                ErrorStateView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.yellow, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.selectedCategory.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
        }
        .task {
            await viewModel.searchMealsInCategory()
        }
    }
}

private extension CategoryFilterView
{
    var preview: some View {
        ScrollView {
            MealGridPreview()
        }
    }
}
