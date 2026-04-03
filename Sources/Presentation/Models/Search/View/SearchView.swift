//
//  SearchView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct SearchView: View {
    @State private var vm = SearchViewModel(
        repository: SearchRepository(
            service: CulinarNetworkService()
        )
    )
    @State private var searchTask: Task<Void, Never>?
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(searchText: $vm.searchText, onSearch: {
                    Task { await vm.searchMeals() }
                })
                .padding(.top, 8)
                .onChange(of: vm.searchText) {
                    guard !vm.isInCategoryMode else { return }
                    searchTask?.cancel()
                    searchTask = Task {
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        await vm.searchMeals()
                    }
                }
                
                if case .success(let meals) = vm.searchResult {
                    if meals.isEmpty {
                        EmptyStateView()
                    } else {
                        MealListView(meals: meals)
                    }
                } else {
                    switch vm.categoriesState {
                    case .idle:
                        preview
                    case .loading:
                        preview
                    case .success(let categories):
                        ScrollView {
                            categoriesHeader
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 12),
                                GridItem(.flexible(), spacing: 12)
                            ], spacing: 16) {
                                ForEach(categories) { category in
                                    NavigationLink(destination: CategoryFilterView(vm: vm, selectedCategory: category)) {
                                        CategoryCard(category: category)
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
                vm.searchText = ""
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
        }
    }
}


#Preview {
    SearchView()
}


