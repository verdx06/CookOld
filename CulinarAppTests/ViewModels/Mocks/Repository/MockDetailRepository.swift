//
//  MockDetailRepository.swift
//  CulinarAppTests
//
//  Created by Виталий Багаутдинов on 09.04.2026.
//

import Foundation
@testable import CulinarApp

final class MockDetailRepository: DetailRepository
{
    enum MockError: Error
    {
        case noStubbedResult
    }

    var getMealDetailsCallCount: Int { requestedIds.count }
    private(set) var requestedIds: [String] = []

    var result: Result<Meal, Error>?

    func getMealDetails(id: String) async throws -> Meal {
        requestedIds.append(id)
        guard let result else { throw MockError.noStubbedResult }
        return try result.get()
    }
}

