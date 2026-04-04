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

    @State var activeTab: CustomTab = .home

    var body: some View {
        TabView(selection: $activeTab) {
            Tab("main_title".localized(), systemImage: "house.fill", value: .home) {
                HomeView()
            }

            Tab("favourite_title".localized(), systemImage: "heart.fill", value: .favorite) {
                FavoriteView()
            }

            Tab("dish_build_title".localized(), systemImage: "cooktop.fill", value: .dish) {
                DishBuilderView()
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
    MainView()
}
