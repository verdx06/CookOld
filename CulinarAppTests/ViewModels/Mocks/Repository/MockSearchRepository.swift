//
//  MockSearchRepository.swift
//  CulinarAppTests
//
//  Created by Варя Черепенникова on 07.04.2026.
//

import Foundation
@testable import CulinarApp

final class MockSearchRepository: SearchRepository {
    var categoriesResult: Result<[MealCategory], Error> = .success([])
    var searchResult: Result<[Meal], Error> = .success([])

    func loadCategories() async throws -> [MealCategory] {
        try categoriesResult.get()
    }

    func searchMeals(name: String) async throws -> [Meal] {
        try searchResult.get()
    }

    func searchMealsByCategories(category: MealCategory) async throws -> [Meal] {
        try searchResult.get()
    }

    func searchMealsInCategory(name: String, category: MealCategory) async throws -> [Meal] {
        try searchResult.get()
    }
}
