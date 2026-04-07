//
//  HomeUseCase.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 03.04.2026.
//

import Foundation

protocol HomeUseCase
{
    func getPopularMeals() async throws -> MealResponse
    func getRecentMeals() async throws -> MealResponse
}

final class HomeUseCaseImpl: HomeUseCase
{
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func getPopularMeals() async throws -> MealResponse {
        try await self.repository.getPopularMeals()
    }

    func getRecentMeals() async throws -> MealResponse {
        try await self.repository.getRecentMeals()
    }
}
