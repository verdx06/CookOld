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
        if case .success(let meals) = vm.searchResult {
            if meals.isEmpty {
                EmptyStateView()
            } else {
                MealListView(meals: meals)
                    .transition(.opacity)
            }
        } else {
            CategoriesSection(vm: vm)
        }
    }
}

