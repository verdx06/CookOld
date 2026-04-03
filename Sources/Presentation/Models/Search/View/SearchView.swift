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
            .onChange(of: viewModel.searchText) {
                viewModel.scheduleSearch()
            }
        }
    }
<<<<<<< HEAD
=======
    
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
>>>>>>> f590069 (Экран поиска)
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
