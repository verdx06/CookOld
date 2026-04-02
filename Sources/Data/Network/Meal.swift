//
//  Meal.swift
//  CulinarApp
//
//  Created by eventya on 02.04.2026.
//

// MARK: - Meal
struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strArea: String?      // Optional, в некоторых ответах API этого поля нет
    let strCategory: String?

    var id: String { idMeal }
}

struct MealResponse: Codable {
    let meals: [Meal]?          // Optional — API возвращает null если ничего не найдено
}

// MARK: - Category
struct Category: Codable, Identifiable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String

    var id: String { idCategory }
}

struct CategoryResponse: Codable {
    let categories: [Category]
}
