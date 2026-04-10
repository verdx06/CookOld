//
//  MainView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

enum CustomTab
{
    case home
    case favorite
    case dish
    case search
}

struct MainView: View
{
    let diContainer: DIContainer
    @State var activeTab: CustomTab = .home
    let favoriteViewModel: FavoriteViewModel
    let dishBuilderViewModel: DishBuilderViewModel

    var body: some View {
        TabView(selection: $activeTab) {
            Tab("main_title".localized(), systemImage: "house.fill", value: .home) {
                HomeView(viewModel: self.diContainer.homeViewModel)
            }

            Tab("favourite_title".localized(), systemImage: "heart.fill", value: .favorite) {
                FavoriteView(viewModel: favoriteViewModel)
            }

            Tab("dish_build_title".localized(), systemImage: "frying.pan.fill", value: .dish) {
                NavigationStack {
                    DishBuilderView(viewModel: dishBuilderViewModel)
                }
            }

            Tab(value: .search, role: .search) {
                SearchView(
                    viewModel: SearchViewModel(
                        repository: SearchRepositoryImpl(
                            service: NetworkService()
                        )
                    )
                )
            }
        }
    }
}

#Preview {
    MainView(
        diContainer: DIContainer(),
        favoriteViewModel: FavoriteViewModel(
            repository: StubFavouritesRepository()
        ),
        dishBuilderViewModel: DishBuilderViewModel(network: NetworkService())
    )
}
