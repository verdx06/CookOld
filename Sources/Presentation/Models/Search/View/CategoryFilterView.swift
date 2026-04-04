//
//  CategoryFilterView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct CategoryFilterView: View
{
    @Bindable var viewModel: SearchViewModel
    var selectedCategory: MealCategory

    var body: some View {
        VStack {
            SearchBar(searchText: $viewModel.searchText, onSearch: {
                Task { await viewModel.searchMealsInCategory(category: selectedCategory) }
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
                            await viewModel.searchMealsInCategory(category: selectedCategory)
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
                Text(selectedCategory.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
        }
        .task {
            await viewModel.searchMealsInCategory(category: selectedCategory)
        }
        .onAppear {
            viewModel.searchText = ""
            viewModel.isInCategoryMode = true
        }
        .onDisappear {
            viewModel.searchResult = .idle
            viewModel.searchText = ""
            viewModel.isInCategoryMode = false
        }
        .onChange(of: viewModel.searchText) {
            viewModel.scheduleCategorySearch(category: selectedCategory)
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
