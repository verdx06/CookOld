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
                Task { await vm.searchMealsByCategories(category: selectedCategory) }
            })
            .padding()
            
            switch vm.searchResult {
            case .idle:
                ScrollView {
                    MealGridPreview()
                }
            case .loading:
                ScrollView {
                    MealGridPreview()
                }
            case .success(let meals):
                MealListView(meals: meals)
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
            }
        }
        .task {
            await vm.searchMealsByCategories(category: selectedCategory)
        }
        .onDisappear() {
            vm.searchResult = .idle
            vm.searchText = ""
        }
    }
}
