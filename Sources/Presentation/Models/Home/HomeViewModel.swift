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
        case idle
        case loading
        case loaded
        case failed(String)
    }

    var contentState: State = .idle
    var popularMeals = MealResponse(meals: [])
    var recentMeals = MealResponse(meals: [])

    private let repository: HomeRepository
    private let makeDetailViewModel: (String) -> DetailViewModel

    init(
        repository: HomeRepository,
        makeDetailViewModel: @escaping (String) -> DetailViewModel
    ) {
        self.repository = repository
        self.makeDetailViewModel = makeDetailViewModel
    }

    func detailViewModel(for mealId: String) -> DetailViewModel {
        self.makeDetailViewModel(mealId)
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
            async let popular = self.repository.getPopularMeals()
            async let recent = self.repository.getRecentMeals()
            let (popularResult, recentResult) = try await (popular, recent)
            self.popularMeals = popularResult
            self.recentMeals = recentResult
            self.contentState = .loaded
        } catch {
            self.contentState = .failed(error.localizedDescription)
        }
    }
}
