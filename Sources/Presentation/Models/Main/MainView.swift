//
//  MainView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct MainView: View {
    
    @State var activeTab: CustomTab = .home
    
    var body: some View {
        TabView(selection: $activeTab) {
            Tab.init(value: .home) {
                HomeView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            Tab.init(value: .favorite) {
                FavoriteView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            Tab.init(value: .dish) {
                DishBuilderView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            customTabbar()
        }
    }
}

private extension MainView {
    @ViewBuilder
    func customTabbar() -> some View {
        VStack {
            HStack(spacing: 10) {
                GeometryReader { geo in
                    CustomTabBar(size: geo.size, activeTab: $activeTab) { tab in
                        VStack {
                            Image(systemName: tab.symbol)
                                .font(.title3)
                            Text(tab.rawValue)
                                .font(.system(size: 10))
                        }
                        .symbolVariant(.fill)
                        .frame(maxWidth: .infinity)
                    }
                }
                ZStack {
                    Button {
                        //TODO: - Task 9 navigate to SearchView
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 22))
                            .foregroundStyle(.foreground)
                    }
                }
                .frame(width: 55, height: 55)
                .background(Color.gray.opacity(0.08), in: Capsule())
                .overlay(
                    Capsule().stroke(Color.gray.opacity(0.18), lineWidth: 1)
                )
            }
            .frame(height: 55)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MainView()
}
