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

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        Group {
            switch self.viewModel.contentState {
            case .loading:
                ProgressView("Загрузка…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded:
                self.loadedContent
            case .failed(let message):
                NetworkErrorView(message: message) {
                    Task {
                        await self.viewModel.loadContent()
                    }
                }
            }
        }
        .task {
            await self.viewModel.loadContent()
        }
    }
}

private extension HomeView
{
    var loadedContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Popular")
                    .font(.title.bold())
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(self.viewModel.randomMeals, id: \.self) { randomMeal in
                            CardPopularDishView(
                                image: randomMeal.thumbURL ?? "",
                                text: randomMeal.title
                            )
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

                ForEach(self.viewModel.popularMeals, id: \.self) { popularMeal in
                    CardDishView(
                        title: popularMeal.title,
                        image: popularMeal.thumbURL ?? "",
                        category: popularMeal.category ?? "",
                        area: popularMeal.area ?? "",
                        isFavorite: false,
                        onFavoriteTap: {}
                    )
                    .padding()
                }
            }
        }
        .refreshable {
            await self.viewModel.reload()
        }
    }
}

#Preview {
    HomeView(viewModel: DIContainer().makeHomeViewModel())
}
