//
//  CulinarAppApp.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 31.03.2026.
//

import SwiftUI

@main
struct CulinarAppApp: App
{
    private let diContainer = DIContainer()
    @State private var repository = SwiftDataFavouritesRepository()

    var body: some Scene {
        WindowGroup {
            MainView(diContainer: self.diContainer)
                .environment(repository)
        }
    }
}
