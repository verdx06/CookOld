import SwiftUI

struct SmallCard: View {
    let meal: Meal
    let isLiked: Bool
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "fork.knife")
                        .foregroundColor(.gray)
                default:
                    Color.gray.opacity(0.2)
                }
            }
            .frame(width: 100, height: 100)
            .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(meal.strMeal)
                    .font(.headline)
                    .lineLimit(2)

                HStack(spacing: 4) {
                    Text(getFlag(for: meal.strArea ?? ""))
                    Text(meal.strArea ?? "Неизвестно")
                    Text("·")
                    Text("20 min")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding(.leading, 12)

            Spacer()

            Button(action: onToggle) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? .red : .gray)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 44, height: 44)
            }
            .padding(.trailing, 8)
        }
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
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

#Preview {
    SmallCard(
        meal: Meal(
            idMeal: "1",
            strMeal: "Pancakes",
            strMealThumb: "https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg",
            strArea: "American",
            strCategory: "Breakfast"
        ),
        isLiked: true,
        onToggle: {}
    )
}
