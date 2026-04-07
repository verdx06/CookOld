//
//  SearchView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel: SearchViewModel
    let diContainer: DIContainer

    init(viewModel: SearchViewModel, diContainer: DIContainer) {
        self.viewModel = viewModel
        self.diContainer = diContainer
    }

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(searchText: $viewModel.searchText, onSearch: {
                    Task { await viewModel.searchMeals() }
                })
                .padding(.top, 8)
                SearchContentView(viewModel: viewModel, diContainer: diContainer)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onChange(of: viewModel.searchText) {
                viewModel.scheduleSearch()
            }
        }
    }
}

#Preview {
    let di = DIContainer()
    SearchView(viewModel: di.makeSearchViewModel(), diContainer: di)
}
