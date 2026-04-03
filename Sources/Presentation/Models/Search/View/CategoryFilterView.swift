//
//  CategoryFilterView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct CategoryFilterView : View {
    @Bindable var vm : SearchViewModel
    @State private var searchTask: Task<Void, Never>?
    var selectedCategory: MealCategory
    
    var body: some View {
        VStack {
            SearchBar(searchText: $vm.searchText, onSearch: {
                Task { await vm.searchMealsInCategory(category: selectedCategory) }
            })
            .padding()
            
            switch vm.searchResult {
            case .idle:
                preview
            case .loading:
                preview
            case .success(let meals):
                if meals.isEmpty {
                    EmptyStateView()
                } else {
                    MealListView(meals: meals)
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
            searchTask?.cancel()
            searchTask = Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                await vm.searchMealsInCategory(category: selectedCategory)
            }
        }
    }
    
    var preview : some View {
        ScrollView {
            MealGridPreview()
        }
    }
}
