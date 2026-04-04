//
//  Meal.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import Foundation

// MARK: - Root Response
struct MealResponse: Codable
{
    let meals: [Meal]?
}

// MARK: - Meal
struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealAlternate: String?
    var strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?

    // Ингредиенты (до 20)
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?

    // Меры (до 20)
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?

    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?

    var id: String { idMeal }

    // MARK: - Computed Properties для удобства работы

    /// Возвращает массив всех непустых ингредиентов
    var ingredients: [String] {
        return [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4,
            strIngredient5, strIngredient6, strIngredient7, strIngredient8,
            strIngredient9, strIngredient10, strIngredient11, strIngredient12,
            strIngredient13, strIngredient14, strIngredient15, strIngredient16,
            strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ].compactMap { $0 }.filter { !$0.isEmpty }
    }

    /// Возвращает массив всех непустых мер
    var measures: [String] {
        return [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4,
            strMeasure5, strMeasure6, strMeasure7, strMeasure8,
            strMeasure9, strMeasure10, strMeasure11, strMeasure12,
            strMeasure13, strMeasure14, strMeasure15, strMeasure16,
            strMeasure17, strMeasure18, strMeasure19, strMeasure20
        ].compactMap { $0 }.filter { !$0.isEmpty }
    }

    var cookingTime: Int {
        let sum = idMeal.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return 15 + (sum % 76)
    }

    /// Возвращает массив пар (ингредиент, мера)
    var ingredientsWithMeasures: [(ingredient: String, measure: String)] {
        var result: [(String, String)] = []
        for index in 0..<min(ingredients.count, measures.count) {
            result.append((ingredients[index], measures[index]))
        }
        return result
    }
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

// MARK: - Preview / Testing
extension Meal {
    init(idMeal: String, strMeal: String, strMealThumb: String, strArea: String? = nil, strCategory: String? = nil) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strArea = strArea
        self.strCategory = strCategory
        self.strMealAlternate = nil
        self.strInstructions = nil
        self.strTags = nil
        self.strYoutube = nil
        self.strIngredient1 = nil; self.strIngredient2 = nil; self.strIngredient3 = nil
        self.strIngredient4 = nil; self.strIngredient5 = nil; self.strIngredient6 = nil
        self.strIngredient7 = nil; self.strIngredient8 = nil; self.strIngredient9 = nil
        self.strIngredient10 = nil; self.strIngredient11 = nil; self.strIngredient12 = nil
        self.strIngredient13 = nil; self.strIngredient14 = nil; self.strIngredient15 = nil
        self.strIngredient16 = nil; self.strIngredient17 = nil; self.strIngredient18 = nil
        self.strIngredient19 = nil; self.strIngredient20 = nil
        self.strMeasure1 = nil; self.strMeasure2 = nil; self.strMeasure3 = nil
        self.strMeasure4 = nil; self.strMeasure5 = nil; self.strMeasure6 = nil
        self.strMeasure7 = nil; self.strMeasure8 = nil; self.strMeasure9 = nil
        self.strMeasure10 = nil; self.strMeasure11 = nil; self.strMeasure12 = nil
        self.strMeasure13 = nil; self.strMeasure14 = nil; self.strMeasure15 = nil
        self.strMeasure16 = nil; self.strMeasure17 = nil; self.strMeasure18 = nil
        self.strMeasure19 = nil; self.strMeasure20 = nil
        self.strSource = nil
        self.strImageSource = nil
        self.strCreativeCommonsConfirmed = nil
        self.dateModified = nil
    }
}
