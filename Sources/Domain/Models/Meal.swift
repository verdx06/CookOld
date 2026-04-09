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

    var isLiked: Bool = false

    var id: String { idMeal }

    var imageURL: URL? { URL(string: strMealThumb) }

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
            return val.flatMap { $0.isEmpty ? nil : $0 }
        }

        measures = (1...20).compactMap { index in
            let val = try? container.decodeIfPresent(String.self, forKey: .init("strMeasure\(index)"))

            return val.flatMap { $0.isEmpty ? nil : $0 }
        }
    }

    // MARK: - Get flag
    func getFlag() -> String {
        switch self.strArea {
        case "American":   return "🇺🇸"
        case "British":    return "🇬🇧"
        case "Canadian":   return "🇨🇦"
        case "Chinese":    return "🇨🇳"
        case "Croatian":   return "🇭🇷"
        case "Dutch":      return "🇳🇱"
        case "Egyptian":   return "🇪🇬"
        case "Filipino":   return "🇵🇭"
        case "French":     return "🇫🇷"
        case "Greek":      return "🇬🇷"
        case "Indian":     return "🇮🇳"
        case "Irish":      return "🇮🇪"
        case "Italian":    return "🇮🇹"
        case "Jamaican":   return "🇯🇲"
        case "Japanese":   return "🇯🇵"
        case "Kenyan":     return "🇰🇪"
        case "Malaysian":  return "🇲🇾"
        case "Mexican":    return "🇲🇽"
        case "Moroccan":   return "🇲🇦"
        case "Polish":     return "🇵🇱"
        case "Portuguese": return "🇵🇹"
        case "Russian":    return "🇷🇺"
        case "Spanish":    return "🇪🇸"
        case "Thai":       return "🇹🇭"
        case "Tunisian":   return "🇹🇳"
        case "Turkish":    return "🇹🇷"
        case "Ukrainian":  return "🇺🇦"
        case "Vietnamese": return "🇻🇳"
        default:           return "🏳️"
        }
    }
    // MARK: - meal info
    func getMealInfo() -> String {
        let area = self.strArea ?? "unknown".localized()
        let flag = self.areaFlag
        return "\(flag) \(area)"
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

// MARK: - Display Helpers
extension Meal {
    var mealInfo: String {
        let area = strArea ?? "unknown".localized()
        let flag = areaFlag
        return "\(flag) \(area)"
    }

    var areaFlag: String {
        switch strArea {
        case "American":   return "🇺🇸"
        case "British":    return "🇬🇧"
        case "Canadian":   return "🇨🇦"
        case "Chinese":    return "🇨🇳"
        case "Croatian":   return "🇭🇷"
        case "Dutch":      return "🇳🇱"
        case "Egyptian":   return "🇪🇬"
        case "Filipino":   return "🇵🇭"
        case "French":     return "🇫🇷"
        case "Greek":      return "🇬🇷"
        case "Indian":     return "🇮🇳"
        case "Irish":      return "🇮🇪"
        case "Italian":    return "🇮🇹"
        case "Jamaican":   return "🇯🇲"
        case "Japanese":   return "🇯🇵"
        case "Kenyan":     return "🇰🇪"
        case "Malaysian":  return "🇲🇾"
        case "Mexican":    return "🇲🇽"
        case "Moroccan":   return "🇲🇦"
        case "Polish":     return "🇵🇱"
        case "Portuguese": return "🇵🇹"
        case "Russian":    return "🇷🇺"
        case "Spanish":    return "🇪🇸"
        case "Thai":       return "🇹🇭"
        case "Tunisian":   return "🇹🇳"
        case "Turkish":    return "🇹🇷"
        case "Ukrainian":  return "🇺🇦"
        case "Vietnamese": return "🇻🇳"
        default:           return "🏳️"
        }
    }
}

// MARK: - Preview / Testing
extension Meal {
    init(
        idMeal: String,
        strMeal: String,
        strMealThumb: String,
        strArea: String? = nil,
        strCategory: String? = nil,
        isLiked: Bool = false
    ) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strArea = strArea
        self.strCategory = strCategory
        self.isLiked = isLiked
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
