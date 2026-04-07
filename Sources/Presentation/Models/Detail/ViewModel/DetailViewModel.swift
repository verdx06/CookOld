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

    private let mealId: String
    private let usecase: DetailUseCase

    init(mealId: String, usecase: DetailUseCase) {
        self.mealId = mealId
        self.usecase = usecase
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
            self.meal = try await self.usecase.getMealDetails(id: self.mealId)
            self.contentState = .loaded
        } catch {
            self.contentState = .failed(error.localizedDescription)
        }
    }
}
