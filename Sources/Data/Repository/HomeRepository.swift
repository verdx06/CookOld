//
//  HomeRepository.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 03.04.2026.
//

import Foundation

protocol HomeRepository
{
    func getPopularMeals() async throws -> [MealModel]
    func getRandomMeals() async throws -> [MealModel]
}

final class HomeRepositoryImpl: HomeRepository
{
    func getPopularMeals() async throws -> [MealModel] {
        try await self.fetchMeals(urlString: "https://www.themealdb.com/api/json/v2/9973533/latest.php")
    }

    func getRandomMeals() async throws -> [MealModel] {
        try await self.fetchMeals(urlString: "https://www.themealdb.com/api/json/v2/9973533/randomselection.php")
    }

    private func fetchMeals(urlString: String) async throws -> [MealModel] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)

        struct MealsResponse: Decodable
        {
            let meals: [MealModel]?
        }

        let decoded = try JSONDecoder().decode(MealsResponse.self, from: data)
        return decoded.meals ?? []
    }
}
