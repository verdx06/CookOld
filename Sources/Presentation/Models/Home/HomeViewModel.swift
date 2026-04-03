//
//  HomeViewModel.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 03.04.2026.
//

import Foundation

@MainActor
@Observable
final class HomeViewModel
{
    enum State: Equatable
    {
        case loading
        case loaded
        case failed(String)
    }

    var contentState: State = .loading
    var popularMeals: [MealModel] = []
    var randomMeals: [MealModel] = []

    private let usecase: HomeUseCase

    init(usecase: HomeUseCase) {
        self.usecase = usecase
    }

    func loadContent() async {
        self.contentState = .loading
        await self.reload()
    }

    func reload() async {
        do {
            async let popular = self.usecase.getPopularMeals()
            async let random = self.usecase.getRandomMeals()
            let (popularResult, randomResult) = try await (popular, random)
            self.popularMeals = popularResult
            self.randomMeals = randomResult
            self.contentState = .loaded
        } catch {
            self.contentState = .failed(error.localizedDescription)
        }
    }
}
