//
//  SearchView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct SearchView: View
{
    @State private var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(searchText: $viewModel.searchText, onSearch: {
                    Task { await viewModel.searchMeals() }
                })
                .padding(.top, 8)

                SearchContentView(viewModel: viewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .task {
                await viewModel.loadCategories()
            }
            .onAppear {
                viewModel.searchResult = .idle
                viewModel.searchText = ""
            }
            .onChange(of: viewModel.searchText) {
                guard viewModel.isInCategoryMode == false else { return }
                viewModel.scheduleSearch()
            }
        }
    }
}

#Preview {
    SearchView(
        viewModel: SearchViewModel(
            repository: SearchRepositoryImpl(
                service: NetworkService()
            )
        )
    )
}
