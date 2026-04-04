//
//  CategoryFilterView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct CategoryFilterView : View {
    @State private var vm: CategoryViewModel
    var selectedCategory: MealCategory
    
    init(selectedCategory: MealCategory, repository: SearchRepository) {
        self.selectedCategory = selectedCategory
        self._vm = State(initialValue: CategoryViewModel(repository: repository))
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $vm.searchText, onSearch: {
                Task { await vm.searchMealsInCategory(category: selectedCategory) }
            })
            .padding()
            
            switch vm.searchResult {
            case .idle, .loading:
                preview
            case .success(let meals):
                if meals.isEmpty {
                    EmptyStateView()
                } else {
                    MealListView(meals: meals)
                        .refreshable {
                            await vm.searchMealsInCategory(category: selectedCategory)
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
            await vm.searchMealsInCategory(category: selectedCategory)
        }
        .onChange(of: vm.searchText) {
            vm.scheduleSearch(category: selectedCategory)
        }
    }
}

private extension CategoryFilterView {
    var preview : some View {
        ScrollView {
            MealGridPreview()
        }
    }
}

