//
//  FavoriteView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct FavoriteView: View {
    @State private var viewModel: FavoriteViewModel

    init(repository: SwiftDataFavouritesRepository) {
        _viewModel = State(initialValue: FavoriteViewModel(repository: repository))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("favourite_title".localized())
                .font(.largeTitle)
                .bold()
                .padding(.horizontal, 16)
                .padding(.top, 10)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("recipe_finder".localized(), text: $viewModel.searchText)
                if !viewModel.searchText.isEmpty {
                    Button("cancel".localized()) {
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
                        SmallCardView(viewModel: SmallCardViewModel(
                            meal: meal,
                            isLiked: !viewModel.mealToBeRemoved(meal.idMeal),
                            onToggle: { viewModel.toggle(meal) }
                        ))
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
    let repository = SwiftDataFavouritesRepository()
    let _ = repository.resetSeed()
    FavoriteView(repository: repository)
}
