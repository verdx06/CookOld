//
//  CategoryGridSection.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 03.04.2026.
//

import SwiftUI

struct CategoryGridSection: View {
    let vm: SearchViewModel
    let categories: [MealCategory]

    var body: some View {
        ScrollView {
            CategoriesHeader()
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(categories, id: \.id) { category in
                    NavigationLink(
                        destination: CategoryFilterView(selectedCategory: category, repository: vm.repository)
                    ) {
                        CategoryCard(category: category)
                            .frame(maxWidth: .infinity)
                            .transition(.opacity.combined(with: .scale(scale: 0.9)))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
        .refreshable { await vm.loadCategories() }
    }
}
