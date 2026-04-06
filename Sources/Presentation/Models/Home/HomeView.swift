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
    let diContainer: DIContainer

    init(viewModel: HomeViewModel, diContainer: DIContainer) {
        _viewModel = State(initialValue: viewModel)
        self.diContainer = diContainer
    }

    var body: some View {
        Group {
            switch self.viewModel.contentState {
            case .idle, .loading:
                ProgressView("Загрузка…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded:
                self.loadedContent
            case .failed(let message):
                ErrorStateView(detailMessage: message) {
                    Task { await self.viewModel.retry() }
                }
            }
        }
        .onAppear {
            Task {
                await self.viewModel.loadContent()
            }
        }
    }
}

private extension HomeView
{
    var loadedContent: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Popular")
                        .font(.title.bold())
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(self.viewModel.popularMeals.meals ?? [], id: \.idMeal) { meal in
                                NavigationLink(value: meal) {
                                    CardPopularDishView(
                                        image: meal.strMealThumb,
                                        text: meal.strMeal
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    Text("Recent")
                        .font(.title.bold())
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, 12)

                    ForEach(self.viewModel.recentMeals.meals ?? [], id: \.idMeal) { meal in
                        ZStack(alignment: .topTrailing) {
                            NavigationLink(value: meal) {
                                CardDishView(
                                    title: meal.strMeal,
                                    imageURL: meal.imageURL,
                                    category: meal.strCategory ?? "",
                                    area: meal.strArea ?? "",
                                    isFavorite: false,
                                    showsFavoriteButton: false,
                                    onFavoriteTap: {}
                                )
                                .padding()
                            }
                            .buttonStyle(.plain)

                            Button {
                                // TODO: добавить действие для лайка на главном экране
                            } label: {
                                Image(systemName: "heart")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(Color.primary.opacity(0.85))
                                    .padding(8)
                                    .background(.ultraThinMaterial, in: Circle())
                            }
                            .buttonStyle(.plain)
                            .padding(.trailing, 24)
                            .padding(.top, 24)
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .refreshable {
                await self.viewModel.reload()
            }
            .navigationDestination(for: Meal.self) { meal in
                DetailView(
                    initialMeal: meal,
                    viewModel: self.diContainer.makeDetailViewModel(mealId: meal.idMeal)
                )
            }
        }
    }
}

#Preview {
    let di = DIContainer()
    HomeView(viewModel: di.makeHomeViewModel(), diContainer: di)
}
