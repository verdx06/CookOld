import SwiftUI

struct IngredientCardView: View {
    let ingredient: Ingredient
    let onClick: () -> Void
    let isChosen: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottomLeading) {
                Group {
                    if let urlString = ingredient.strThumb, let url = URL(string: urlString) {
                        LoadableImage(url: url, contentMode: .fit)
                    } else {
                        PreviewRectangle()
                    }
                }
                .frame(width: 120, height: 70)
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.1),
                        Color.black.opacity(0.3)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: 120, height: 70)
                Text(ingredient.strIngredient)
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(6)
            }
            .frame(width: 120, height: 70)
            .background(Color(.white))
            .cornerRadius(12)

            Button(action: {
                onClick()
            }) {
                Image(systemName: isChosen ? "xmark.circle.fill" : "plus.circle.fill")
                    .tint(Color(.systemGray))
                    .background(
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.05),
                                        Color.white.opacity(0)
                                    ]),
                                    center: .center,
                                    startRadius: 5,
                                    endRadius: 22
                                )
                            )
                            .frame(width: 24, height: 24)
                    )
            }
            .contentShape(Rectangle())
            .padding(0)
            .frame(width: 30, height: 30)
            .clipped()
        }
        .frame(width: 120, height: 70)
        .clipped()
        .onTapGesture { onClick() }
    }
}

#Preview {
    HStack {
        IngredientCardView(
            ingredient: Ingredient(
                idIngredient: "1",
                strIngredient: "Chicken",
                strDescription: nil,
                strThumb: "https://www.themealdb.com/images/ingredients/Chicken.png",
                strType: nil
            ),
            onClick: {},
            isChosen: false
        )
        IngredientCardView(
            ingredient: Ingredient(
                idIngredient: "2",
                strIngredient: "Garlic",
                strDescription: nil,
                strThumb: "https://www.themealdb.com/images/ingredients/Garlic.png",
                strType: nil
            ),
            onClick: {},
            isChosen: true
        )
    }
}
