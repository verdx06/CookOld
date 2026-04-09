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
    private var loadingTask: Task<Void, Never>?

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

    func loadContent() {
        guard case .idle = self.contentState else { return }
        self.contentState = .loading
        self.startReloadTask()
    }

    func retry() {
        self.contentState = .loading
        self.startReloadTask()
    }

    func reload() async {
        self.startReloadTask()
        await self.loadingTask?.value
    }

    func cancelActiveRequests() {
        self.loadingTask?.cancel()
        self.loadingTask = nil

        if case .loading = self.contentState {
            self.contentState = .idle
        }
    }

    private func startReloadTask() {
        self.loadingTask?.cancel()
        self.loadingTask = Task { [weak self] in
            guard let self else { return }
            await self.performReload()
            self.loadingTask = nil
        }
    }

    private func performReload() async {
        do {
            async let popular = self.repository.getPopularMeals()
            async let recent = self.repository.getRecentMeals()
            let (popularResult, recentResult) = try await (popular, recent)

            guard Task.isCancelled == false else { return }

            self.popularMeals = popularResult
            self.recentMeals = recentResult
            self.contentState = .loaded
        } catch {
            guard Task.isCancelled == false else { return }
            self.contentState = .failed(error.localizedDescription)
        }
    }
}
