import SwiftUI

struct FavouriteCardView: View {
    let meal: Meal
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            Group {
                if let url = URL(string: meal.strMealThumb) {
                    LoadableImage(url: url, contentMode: .fill)
                } else {
                    Image(systemName: "fork.knife")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemGray5))
                }
            }
            .frame(width: 100, height: 100)
            .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(meal.strMeal)
                    .font(.headline)
                    .lineLimit(2)

                Text(meal.mealInfo)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 12)

            Spacer()

            Button(action: onToggle) {
                Image(systemName: meal.isLiked ? "heart.fill" : "heart")
                    .foregroundColor(meal.isLiked ? .red : .gray)
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
}

#Preview {
    FavouriteCardView(
        meal: Meal(
            idMeal: "1",
            strMeal: "Blini Z goyda",
            strMealThumb: "https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg",
            strArea: "Russian",
            strCategory: "Breakfast",
            isLiked: true
        ),
        onToggle: {}
    )
}
