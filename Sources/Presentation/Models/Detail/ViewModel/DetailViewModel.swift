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

    var isFavorite: Bool { favouriteViewModel.isLiked(mealId) }

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
    private let favouriteViewModel: FavoriteViewModel

    init(
        mealId: String,
        repository: DetailRepository,
        favouriteViewModel: FavoriteViewModel
    ) {
        self.mealId = mealId
        self.repository = repository
        self.favouriteViewModel = favouriteViewModel
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
            self.contentState = .loaded
        } catch {
            self.contentState = .failed(error.localizedDescription)
        }
    }

    func toggleFavorite() {
        guard let meal else { return }
        favouriteViewModel.toggleLike(meal)
    }
}
