//
//  SearchContentView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 03.04.2026.
//

import SwiftUI

struct SearchContentView: View {
    var vm : SearchViewModel
    
    var body: some View {
        switch vm.searchResult {
        case .success(let meals):
            if meals.isEmpty {
                EmptyStateView()
            } else {
                MealListView(meals: meals)
                    .transition(.opacity)
                    .refreshable {
                        await vm.searchMeals()
                    }
            }
        case .loading where !vm.searchText.isEmpty:
            ScrollView {
                MealGridPreview()
            }
        default:
            CategoriesSection(vm: vm)
        }
    }
}
