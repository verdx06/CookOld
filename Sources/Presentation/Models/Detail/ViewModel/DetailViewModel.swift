//
//  DetailViewModel.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 07.04.2026.
//

import Foundation

@MainActor
@Observable
final class DetailViewModel
{
    enum State: Equatable
    {
        case idle
        case loading
        case loaded
        case failed(String)
    }

    var contentState: State = .idle
    var meal: Meal?
    var isFavorite = false

    var ingredientRows: [(name: String, measure: String)] {
        guard let meal else { return [] }
        return meal.ingredients.indices.map { index in
            (
                meal.ingredients[index],
                meal.measures.indices.contains(index) ? meal.measures[index] : ""
            )
        }
    }

    private let mealId: String
    private let repository: DetailRepository
    private let favouritesRepository: any FavouritesRepository

    init(
        mealId: String,
        repository: DetailRepository,
        favouritesRepository: any FavouritesRepository
    ) {
        self.mealId = mealId
        self.repository = repository
        self.favouritesRepository = favouritesRepository
        self.syncFavoriteState()
    }

    func loadContent() async {
        guard case .idle = self.contentState else { return }
        self.contentState = .loading
        await self.reload()
    }

    func retry() async {
        self.contentState = .loading
        await self.reload()
    }

    func reload() async {
        do {
            self.meal = try await self.repository.getMealDetails(id: self.mealId)
            self.syncFavoriteState()
            self.contentState = .loaded
        } catch {
            self.contentState = .failed(error.localizedDescription)
        }
    }

    func toggleFavorite() {
        if self.isFavorite {
            self.favouritesRepository.delete(self.mealId)
            self.isFavorite = false
            return
        }

        guard let meal else { return }
        self.favouritesRepository.save(meal)
        self.isFavorite = true
    }

    private func syncFavoriteState() {
        self.isFavorite = self.favouritesRepository
            .fetchAll()
            .contains { $0.idMeal == self.mealId }
    }
}
