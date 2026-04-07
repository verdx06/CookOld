//
//  DetailUseCase.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 07.04.2026.
//

import Foundation

protocol DetailUseCase
{
    func getMealDetails(id: String) async throws -> Meal
}

final class DetailUseCaseImpl: DetailUseCase
{
    private let repository: DetailRepository

    init(repository: DetailRepository) {
        self.repository = repository
    }

    func getMealDetails(id: String) async throws -> Meal {
        try await self.repository.getMealDetails(id: id)
    }
}
