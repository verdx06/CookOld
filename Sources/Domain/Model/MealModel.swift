//
//  MealModel.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 03.04.2026.
//

import Foundation

struct MealModel: Decodable, Hashable
{
    let id: String
    let title: String
    let alternateTitle: String?

    let category: String?
    let area: String?
    let instructions: String?

    let thumbURL: String?
    let youtubeURL: String?

    let tags: [String]?
    let ingredients: [Ingredient]

    let sourceURL: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: String?

    struct Ingredient: Hashable, Identifiable
    {
        let name: String
        let measure: String?

        var id: String { name }
    }

    enum CodingKeys: String, CodingKey
    {
        case idMeal
        case strMeal
        case strMealAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strYoutube
        case strTags
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20

        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20

        case strSource
        case strImageSource
        case strCreativeCommonsConfirmed
        case dateModified
    }

    private static let ingredientKeys: [CodingKeys] = [
        .strIngredient1, .strIngredient2, .strIngredient3, .strIngredient4, .strIngredient5,
        .strIngredient6, .strIngredient7, .strIngredient8, .strIngredient9, .strIngredient10,
        .strIngredient11, .strIngredient12, .strIngredient13, .strIngredient14, .strIngredient15,
        .strIngredient16, .strIngredient17, .strIngredient18, .strIngredient19, .strIngredient20
    ]

    private static let measureKeys: [CodingKeys] = [
        .strMeasure1, .strMeasure2, .strMeasure3, .strMeasure4, .strMeasure5,
        .strMeasure6, .strMeasure7, .strMeasure8, .strMeasure9, .strMeasure10,
        .strMeasure11, .strMeasure12, .strMeasure13, .strMeasure14, .strMeasure15,
        .strMeasure16, .strMeasure17, .strMeasure18, .strMeasure19, .strMeasure20
    ]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .idMeal)
        self.title = try container.decode(String.self, forKey: .strMeal)
        self.alternateTitle = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .strMealAlternate))

        self.category = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .strCategory))
        self.area = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .strArea))
        self.instructions = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .strInstructions))

        self.thumbURL = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .strMealThumb))
        self.youtubeURL = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .strYoutube))

        if let tagsRaw = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .strTags)) {
            self.tags = tagsRaw
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
                .map { String($0) }
        } else {
            self.tags = nil
        }

        var ingredients: [Ingredient] = []
        ingredients.reserveCapacity(20)

        for (ingredientKey, measureKey) in zip(Self.ingredientKeys, Self.measureKeys) {
            let name = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: ingredientKey))
            guard let name else { continue }

            let measure = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: measureKey))
            ingredients.append(Ingredient(name: name, measure: measure))
        }

        self.ingredients = ingredients

        self.sourceURL = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .strSource))
        self.imageSource = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .strImageSource))
        self.creativeCommonsConfirmed = Self.trimmedNil(
            try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        )
        self.dateModified = Self.trimmedNil(try container.decodeIfPresent(String.self, forKey: .dateModified))
    }

    private static func trimmedNil(_ value: String?) -> String? {
        guard let value else { return nil }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}
