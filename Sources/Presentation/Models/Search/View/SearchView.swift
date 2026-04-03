//
//  SearchView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct SearchView: View {
    @State private var vm = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(searchText: $vm.searchText, onSearch: {
                    Task { await vm.searchMeals() }
                })
                .padding(.top, 8)
                
                if case .success(let meals) = vm.searchResult {
                    if meals.isEmpty {
                        EmptyStateView()
                    } else {
                        MealListView(meals: meals)
                            .transition(.opacity)
                    }
                } else {
                    switch vm.categoriesState {
                    case .idle, .loading:
                        preview
                    case .success(let categories):
                        ScrollView {
                            categoriesHeader
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 12) {
                                ForEach(categories) { category in
                                    NavigationLink(destination: CategoryFilterView(vm: vm, selectedCategory: category)) {
                                        CategoryCard(category: category)
                                            .frame(maxWidth: .infinity)
                                            .transition(.opacity.combined(with: .scale(scale: 0.9)))
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                    case .failure:
                        ErrorStateView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .task {
                await vm.loadCategories()
            }
            .onAppear {
                vm.searchResult = .idle
            }
        }
    }
    
    var categoriesHeader: some View {
        Text("Категории")
            .font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
    }
    
    var preview: some View {
        ScrollView {
            categoriesHeader
            CategoryGridPreview()
                .padding(.horizontal)
        }
    }
}


#Preview {
    SearchView()
}


