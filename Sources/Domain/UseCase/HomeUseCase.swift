//
//  HomeUseCase.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 03.04.2026.
//

import Foundation

protocol HomeUseCase
{
    func getPopularMeals() async throws -> [MealModel]
    func getRandomMeals() async throws -> [MealModel]
}

final class HomeUseCaseImpl: HomeUseCase
{
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func getPopularMeals() async throws -> [MealModel] {
        try await self.repository.getPopularMeals()
    }

    func getRandomMeals() async throws -> [MealModel] {
        try await self.repository.getRandomMeals()
    }
}
