//
//  FavouriteRepository.swift
//  CulinarApp
//
//  Created by eventya on 04.04.2026.
//

@MainActor
protocol FavouritesRepository {
    func fetchAll() -> [Meal]
    func save(_ meal: Meal)
    func delete(_ id: String)
}
