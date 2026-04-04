//
//  Meal.swift
//  CulinarApp
//
//  Created by eventya on 02.04.2026.
//

// MARK: - Meal
struct Meal: Decodable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strArea: String?      // Optional, в некоторых ответах API этого поля нет
    let strCategory: String?

    var id: String { idMeal }
}

struct MealResponse: Decodable {
    let meals: [Meal]?          // Optional — API возвращает null если ничего не найдено
}

// MARK: - Category
struct Category: Decodable, Identifiable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String

    var id: String { idCategory }
}

struct CategoryResponse: Decodable {
    let categories: [Category]
}
