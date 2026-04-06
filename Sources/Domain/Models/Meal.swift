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
struct Meal: Decodable, Identifiable {
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

    var cookingTime: Int {
        let sum = idMeal.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return 15 + (sum % 76)
    }

    var ingredientsWithMeasures: [(ingredient: String, measure: String)] {
        zip(ingredients, measures).map { ($0, $1) }
    }

    // MARK: - Custom Decoder
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: DynamicKey.self)

        idMeal                      = try c.decode(String.self, forKey: .init("idMeal"))
        strMeal                     = try c.decode(String.self, forKey: .init("strMeal"))
        strMealAlternate            = try c.decodeIfPresent(String.self, forKey: .init("strMealAlternate"))
        strCategory                 = try c.decodeIfPresent(String.self, forKey: .init("strCategory"))
        strArea                     = try c.decodeIfPresent(String.self, forKey: .init("strArea"))
        strInstructions             = try c.decodeIfPresent(String.self, forKey: .init("strInstructions"))
        strMealThumb                = try c.decode(String.self, forKey: .init("strMealThumb"))
        strTags                     = try c.decodeIfPresent(String.self, forKey: .init("strTags"))
        strYoutube                  = try c.decodeIfPresent(String.self, forKey: .init("strYoutube"))
        strSource                   = try c.decodeIfPresent(String.self, forKey: .init("strSource"))
        strImageSource              = try c.decodeIfPresent(String.self, forKey: .init("strImageSource"))
        strCreativeCommonsConfirmed = try c.decodeIfPresent(String.self, forKey: .init("strCreativeCommonsConfirmed"))
        dateModified                = try c.decodeIfPresent(String.self, forKey: .init("dateModified"))

        ingredients = (1...20).compactMap { i in
            let val = try? c.decodeIfPresent(String.self, forKey: .init("strIngredient\(i)"))
            return val.flatMap { $0.isEmpty ? nil : $0 }
        }

        measures = (1...20).compactMap { i in
            let val = try? c.decodeIfPresent(String.self, forKey: .init("strMeasure\(i)"))
            return val.flatMap { $0.isEmpty ? nil : $0 }
        }
    }
}

// MARK: - DynamicKey
private struct DynamicKey: CodingKey {
    var stringValue: String
    var intValue: Int? { nil }
    init(_ string: String) { self.stringValue = string }
    init?(stringValue: String) { self.stringValue = stringValue }
    init?(intValue: Int) { return nil }
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
        self.strSource = nil
        self.strImageSource = nil
        self.strCreativeCommonsConfirmed = nil
        self.dateModified = nil
        self.ingredients = []
        self.measures = []
    }
}
