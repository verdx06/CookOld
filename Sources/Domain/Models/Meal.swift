//
//  Meal.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import Foundation

// MARK: - Root Response
struct MealResponse: Decodable {
    let meals: [Meal]?
}

// MARK: - Meal
struct Meal: Codable, Hashable
{
    let idMeal: String
    let strMeal: String
    let strMealAlternate: String?
    var strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?

    let ingredients: [String]
    let measures: [String]

    var id: String { idMeal }

    var imageURL: URL? { URL(string: strMealThumb) }

    var cookingTime: Int {
        let sum = idMeal.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return 15 + (sum % 76)
    }
    
    /// Возвращает массив строк для UI (ингредиент + мера по индексу, иначе пусто)
    var ingredientRows: [(name: String, measure: String)] {
        ingredients.indices.map { index in
            (ingredients[index], measures.indices.contains(index) ? measures[index] : "")
        }
    }
}
