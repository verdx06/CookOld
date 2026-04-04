//
//  CategoriesSection.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 03.04.2026.
//

import SwiftUI

struct CategoriesSection: View {
    var vm: SearchViewModel
    
    var body: some View {
        switch vm.categoriesState {
        case .idle, .loading:
            CategoryPreviewSection()
        case .success(let categories):
            CategoryGridSection(vm: vm, categories: categories)
        case .failure:
            ErrorStateView()
        }
    }
}
