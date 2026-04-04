//
//  CategoryFilterView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct CategoryFilterView : View {
    @Bindable var vm : SearchViewModel
    var selectedCategory: MealCategory
    
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
        .onAppear() {
            vm.searchText = ""
            vm.isInCategoryMode = true
        }
        .onDisappear() {
            vm.searchResult = .idle
            vm.searchText = ""
            vm.isInCategoryMode = false
        }
        .onChange(of: vm.searchText) {
            vm.scheduleCategorySearch(category: selectedCategory)
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
