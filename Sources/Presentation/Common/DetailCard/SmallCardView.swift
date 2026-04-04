import SwiftUI

struct SmallCardView: View {
    @State private var viewModel: SmallCardViewModel

    init(viewModel: SmallCardViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: viewModel.meal.strMealThumb)) { phase in
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
                Text(viewModel.meal.strMeal)
                    .font(.headline)
                    .lineLimit(2)

                Text(viewModel.mealInfo)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 12)

            Spacer()

            Button(action: viewModel.toggle) {
                Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.isLiked ? .red : .gray)
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
    SmallCardView(viewModel: SmallCardViewModel(
        meal: Meal(
            idMeal: "1",
            strMeal: "Blini Z goyda",
            strMealThumb: "https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg",
            strArea: "Russian",
            strCategory: "Breakfast"
        ),
        isLiked: false,
        onToggle: {}
    ))
}
