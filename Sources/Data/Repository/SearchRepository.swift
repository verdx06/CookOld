//
//  SearchRepository.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 02.04.2026.
//

import Foundation

protocol SearchRepository
{
    func loadCategories() async throws -> [MealCategory]
    func searchMeals(name: String) async throws -> [Meal]
    func searchMealsByCategories(category: MealCategory) async throws -> [Meal]
    func searchMealsInCategory(name: String, category: MealCategory) async throws -> [Meal]
}

final class SearchRepositoryImpl: SearchRepository
{
    private var service: Network

    init(service: Network) {
        self.service = service
    }

    func loadCategories() async throws -> [MealCategory] {
        let response: CategoriesResponse = try await service.request(url: "/categories.php")
        return response.categories
    }

    func searchMeals(name: String) async throws -> [Meal] {
        let response: MealResponse = try await service.requestData(url: "/search.php", params: ["s": name])
        return response.meals ?? []
    }

    func searchMealsByCategories(category: MealCategory) async throws -> [Meal] {
        let response: MealResponse = try await service.requestData(url: "/filter.php", params: ["c": category.name])
        return (response.meals ?? []).map { meal in
            var meal = meal
            meal.strCategory = category.name
            return meal
        }
    }

    func searchMealsInCategory(name: String, category: MealCategory) async throws -> [Meal] {
        let allMeals = try await searchMealsByCategories(category: category)
        guard name.isEmpty == false else {
            return allMeals
        }
        return allMeals.filter { $0.strMeal.lowercased().contains(name.lowercased()) }
    }
}
