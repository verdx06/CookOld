//
//  FavoriteView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct FavoriteView: View {
    @State var viewModel: FavoriteViewModel
    
    var body: some View {
        NavigationStack {
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
                    if viewModel.searchText.isEmpty == false {
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
                
                if viewModel.filteredMeals.isEmpty {
                    EmptyStateView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.filteredMeals) { meal in
                                NavigationLink {
                                    DetailView(viewModel: viewModel.detailViewModel(for: meal.idMeal))
                                } label: {
                                    SmallCardView(viewModel: SmallCardViewModel(
                                        meal: meal,
                                        isLiked: viewModel.mealToBeRemoved(meal.idMeal) == false,
                                        onToggle: { viewModel.toggle(meal) }
                                    ))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .scrollDismissesKeyboard(.immediately)
                    .refreshable {
                        viewModel.load()
                    }
                }
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("recipe_finder".localized(), text: $viewModel.searchText)
                    if viewModel.searchText.isEmpty == false {
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
                                isLiked: viewModel.mealToBeRemoved(meal.idMeal) == false,
                                onToggle: { viewModel.toggle(meal) }
                            ))
                        }
                    }
                }
                .onAppear {
                    viewModel.load()
                }
            }
        }
    }
}
