//
//  CulinarAppApp.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 31.03.2026.
//
import SwiftUI

@main
struct CulinarAppApp: App {

    private let diContainer = DIContainer()

    var body: some Scene {
        WindowGroup {
            MainView(
                diContainer: diContainer,
                favoriteViewModel: diContainer.favoriteViewModel,
                dishBuilderViewModel: diContainer.dishBuilderViewModel
            )
            .environment(\.imageLoader, diContainer.imageLoader)
            .environment(\.favoriteViewModel, diContainer.favoriteViewModel)
        }
    }
}
