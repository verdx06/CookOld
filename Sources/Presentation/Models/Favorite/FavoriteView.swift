//
//  FavoriteView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct FavoriteView: View {
    @State private var viewModel = FavoriteViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Избранное")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal, 16)
                .padding(.top, 10)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Поиск рецептов...", text: $viewModel.searchText)
                if !viewModel.searchText.isEmpty {
                    Button("Отмена") {
                        viewModel.searchText = ""
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 16)

            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.filteredMeals) { meal in
                        SmallCard(
                            meal: meal,
                            isLiked: !viewModel.isPendingRemoval(meal),
                            onToggle: { viewModel.toggle(meal) }
                        )
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .refreshable {
                viewModel.load()
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
}

#Preview {
    let _ = FavouritesRepository.shared.resetSeed()
    FavoriteView()
}
