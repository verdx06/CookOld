//
//  DetailRepository.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 07.04.2026.
//

import Foundation

protocol DetailRepository
{
    func getMealDetails(id: String) async throws -> Meal
}

final class DetailRepositoryImpl
{
    private let network: Network

    init(network: Network) {
        self.network = network
    }
}

extension DetailRepositoryImpl: DetailRepository
{
    func getMealDetails(id: String) async throws -> Meal {
        let response: MealResponse = try await self.network.requestData(
            url: "/lookup.php",
            params: ["i": id]
        )
        guard let meal = response.meals?.first else {
            throw URLError(.badServerResponse)
        }
        return meal
    }
}
