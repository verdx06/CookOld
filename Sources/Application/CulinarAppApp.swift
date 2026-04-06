//
//  CulinarAppApp.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 31.03.2026.
//

import SwiftUI

@main
struct CulinarAppApp: App {
    private let favouriteViewModel: FavoriteViewModel
    
    init() {
        favouriteViewModel = FavoriteViewModel(repository: SwiftDataFavouritesRepository())
    }

    var body: some Scene {
        WindowGroup {
            MainView(favoriteViewModel: favouriteViewModel)
        }
    }
}
