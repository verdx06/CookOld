//
//  MockHomeUseCase.swift
//  CulinarAppTests
//
//  Created by Виталий Багаутдинов on 06.04.2026.
//

import Foundation
@testable import CulinarApp

final class MockHomeUseCase: HomeUseCase {
    private let popularResult: Result<MealResponse, Error>
    private let recentResult: Result<MealResponse, Error>

    private(set) var popularCalls = 0
    private(set) var recentCalls = 0

    init(
        popularResult: Result<MealResponse, Error> = .success(MealResponse(meals: nil)),
        recentResult: Result<MealResponse, Error> = .success(MealResponse(meals: nil))
    ) {
        self.popularResult = popularResult
        self.recentResult = recentResult
    }

    func getPopularMeals() async throws -> MealResponse {
        self.popularCalls += 1
        return try self.popularResult.get()
    }

    func getRecentMeals() async throws -> MealResponse {
        self.recentCalls += 1
        return try self.recentResult.get()
    }

    func callCounts() -> (Int, Int) {
        (self.popularCalls, self.recentCalls)
    }
}
