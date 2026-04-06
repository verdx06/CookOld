//
//  HomeRepository.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 03.04.2026.
//

import Foundation

protocol HomeRepository
{
    func getPopularMeals() async throws -> MealResponse
    func getRecentMeals() async throws -> MealResponse
}

final class HomeRepositoryImpl
{
    private let network: Network

    init(network: Network) {
        self.network = network
    }
}

extension HomeRepositoryImpl: HomeRepository
{
    func getPopularMeals() async throws -> MealResponse {
        try await self.network.request(url: "/randomselection.php")
    }

    func getRecentMeals() async throws -> MealResponse {
        try await self.network.request(url: "/latest.php")
    }
}
