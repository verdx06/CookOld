//
//  UITestSearchRepository.swift
//  CulinarApp
//

import Foundation

final class UITestSearchRepository: SearchRepository {
    private let categories: [MealCategory] = [
        MealCategory(id: "1", name: "Beef", image: URL(string: "https://www.themealdb.com/images/category/beef.png")!),
        MealCategory(id: "2", name: "Chicken", image: URL(string: "https://www.themealdb.com/images/category/chicken.png")!),
        MealCategory(id: "3", name: "Seafood", image: URL(string: "https://www.themealdb.com/images/category/seafood.png")!)
    ]

    private let meals: [Meal] = [
        Meal(
            idMeal: "52772",
            strMeal: "Teriyaki Chicken Casserole",
            strMealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
            strArea: "Japanese",
            strCategory: "Chicken"
        ),
        Meal(
            idMeal: "52773",
            strMeal: "Honey Teriyaki Salmon",
            strMealThumb: "https://www.themealdb.com/images/media/meals/xxyupu1468262513.jpg",
            strArea: "Japanese",
            strCategory: "Seafood"
        )
    ]

    func loadCategories() async throws -> [MealCategory] {
        categories
    }

    func searchMeals(name: String) async throws -> [Meal] {
        meals
    }

    func searchMealsByCategories(category: MealCategory) async throws -> [Meal] {
        meals
    }

    func searchMealsInCategory(name: String, category: MealCategory) async throws -> [Meal] {
        meals
    }
}
