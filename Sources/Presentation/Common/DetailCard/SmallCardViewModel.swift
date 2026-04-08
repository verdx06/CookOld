//
//  SmallCardViewModel.swift
//  CulinarApp
//
//  Created by eventya on 03.04.2026.
//
import Observation

@Observable
final class SmallCardViewModel {
    let meal: Meal
    var isLiked: Bool
    let onToggle: () -> Void

    init(meal: Meal, isLiked: Bool, onToggle: @escaping () -> Void) {
        self.meal = meal
        self.isLiked = isLiked
        self.onToggle = onToggle
    }

    func toggle() {
        isLiked.toggle()
        onToggle()
    }

    var mealInfo: String {
        let area = meal.strArea ?? "unknown".localized()
        let flag = getFlag(for: area)
        return "\(flag) \(area) · 20 \("minutes".localized())"
    }

    func getFlag(for area: String) -> String {
        switch area {
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
