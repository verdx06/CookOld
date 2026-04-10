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

    var imageURL: URL? { URL(string: strMealThumb) }

    var ingredientsWithMeasures: [(ingredient: String, measure: String)] {
        zip(ingredients, measures).map { ($0, $1) }
    }

    // MARK: - Custom Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)

        idMeal                      = try container.decode(String.self, forKey: .init("idMeal"))
        strMeal                     = try container.decode(String.self, forKey: .init("strMeal"))
        strMealAlternate            = try container.decodeIfPresent(String.self, forKey: .init("strMealAlternate"))
        strCategory                 = try container.decodeIfPresent(String.self, forKey: .init("strCategory"))
        strArea                     = try container.decodeIfPresent(String.self, forKey: .init("strArea"))
        strInstructions             = try container.decodeIfPresent(String.self, forKey: .init("strInstructions"))
        strMealThumb                = try container.decode(String.self, forKey: .init("strMealThumb"))
        strTags                     = try container.decodeIfPresent(String.self, forKey: .init("strTags"))
        strYoutube                  = try container.decodeIfPresent(String.self, forKey: .init("strYoutube"))
        strSource                   = try container.decodeIfPresent(String.self, forKey: .init("strSource"))
        strImageSource              = try container.decodeIfPresent(String.self, forKey: .init("strImageSource"))
        strCreativeCommonsConfirmed = try container
            .decodeIfPresent(
                String.self,
                forKey: .init(
                    "strCreativeCommonsConfirmed"
                )
            )
        dateModified = try container.decodeIfPresent(String.self, forKey: .init("dateModified"))

        ingredients = (1...20).compactMap { index in
            let val = try? container.decodeIfPresent(String.self, forKey: .init("strIngredient\(index)"))
            return val.flatMap { $0.trimmingCharacters(in: .whitespaces).isEmpty ? nil : $0 }
        }

        measures = (1...20).compactMap { index in
            let val = try? container.decodeIfPresent(String.self, forKey: .init("strMeasure\(index)"))
            return val.flatMap { $0.trimmingCharacters(in: .whitespaces).isEmpty ? nil : $0 }
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
