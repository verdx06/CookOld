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
    private let delayNanoseconds: UInt64

    private var popularCalls = 0
    private var recentCalls = 0

    init(
        popularResult: Result<MealResponse, Error>,
        recentResult: Result<MealResponse, Error>,
        delayNanoseconds: UInt64 = 0
    ) {
        self.popularResult = popularResult
        self.recentResult = recentResult
        self.delayNanoseconds = delayNanoseconds
    }

    func getPopularMeals() async throws -> MealResponse {
        self.popularCalls += 1
        if self.delayNanoseconds > 0 {
            try? await Task.sleep(nanoseconds: self.delayNanoseconds)
        }
        return try self.popularResult.get()
    }

    func getRecentMeals() async throws -> MealResponse {
        self.recentCalls += 1
        if self.delayNanoseconds > 0 {
            try? await Task.sleep(nanoseconds: self.delayNanoseconds)
        }
        return try self.recentResult.get()
    }

    func callCounts() -> (popular: Int, recent: Int) {
        (self.popularCalls, self.recentCalls)
    }
}
