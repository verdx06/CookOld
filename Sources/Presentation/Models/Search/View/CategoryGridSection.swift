//
//  CategoryGridSection.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 03.04.2026.
//

import SwiftUI

struct CategoryGridSection: View
{
    let viewModel: SearchViewModel
    let categories: [MealCategory]

    var body: some View {
        ScrollView {
            CategoriesHeader()
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(Array(categories.enumerated()), id: \.element.id) { index, category in
                    NavigationLink(
                        destination: CategoryFilterView(
                            viewModel:
                                CategoryViewModel(
                                    selectedCategory: category,
                                    repository: viewModel.repository,
                                    makeDetailViewModel: viewModel.makeDetailViewModel,
                                )
                            )
                    ) {
                        CategoryCard(category: category)
                            .frame(maxWidth: .infinity)
                            .transition(.opacity.combined(with: .scale(scale: 0.9)))
                    }
                    .buttonStyle(.plain)
                    .accessibilityIdentifier("categoryCard_\(index)")
                }
            }
            .padding(.horizontal)
        }
        .refreshable { await viewModel.loadCategories() }
    }
}
