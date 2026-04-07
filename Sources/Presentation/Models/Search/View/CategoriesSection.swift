//
//  CategoriesSection.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 03.04.2026.
//

import SwiftUI

struct CategoriesSection: View
{
    var viewModel: SearchViewModel
    let diContainer: DIContainer

    var body: some View {
        switch viewModel.categoriesState {
        case .idle, .loading:
            CategoryPreviewSection()
        case .success(let categories):
            CategoryGridSection(viewModel: viewModel, categories: categories, diContainer: diContainer)
        case .failure:
            ErrorStateView()
        }
    }
}
