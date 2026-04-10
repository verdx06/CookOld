//
//  HomeView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct HomeView: View
{
    @State private var viewModel: HomeViewModel
    @Environment(\.favoriteViewModel) private var favoriteViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        ZStack {
            switch self.viewModel.contentState {
            case .idle, .loading:
                ProgressView("loading".localized())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded:
                self.loadedContent
            case .failed(let message):
                ErrorStateView(detailMessage: message) {
                    self.viewModel.retry()
                }
            }
        }
        .onAppear {
            self.viewModel.loadContent()
        }
        .onDisappear {
            self.viewModel.cancelActiveRequests()
        }
    }
}

private extension HomeView
{
    var loadedContent: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("home_popular".localized())
                        .font(.title.bold())
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(self.viewModel.popularMeals.meals ?? [], id: \.idMeal) { meal in
                                NavigationLink {
                                    DetailView(viewModel: self.viewModel.detailViewModel(for: meal.idMeal))
                                } label: {
                                    CardPopularDishView(
                                        image: meal.strMealThumb,
                                        text: meal.strMeal,
                                        isFavorite: self.viewModel.isFavorite(meal.idMeal),
                                        onFavoriteTap: {
                                            self.viewModel.toggleFavorite(meal)
                                        }
                                    )
                                }
                            .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    Text("home_recent".localized())
                        .font(.title.bold())
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, 12)

                    ForEach(self.viewModel.recentMeals.meals ?? [], id: \.idMeal) { meal in
                        let stamped = favoriteViewModel.stamped(meal)
                        NavigationLink {
                            DetailView(viewModel: self.viewModel.detailViewModel(for: meal.idMeal))
                        } label: {
                            CardDishView(meal: stamped) {
                                favoriteViewModel.toggleLike(meal)
                            }
                            .padding()
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .refreshable {
                await self.viewModel.reload()
            }
        }
    }
}

#Preview {
    let container = DIContainer()
    HomeView(viewModel: container.homeViewModel)
        .environment(\.favoriteViewModel, container.favoriteViewModel)
}
