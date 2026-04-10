import SwiftUI

struct IngredientSmallCardView: View {
    let ingredient: Ingredient
    let onClick: () -> Void

    var body: some View {
        HStack(spacing: 6) {
            Button(action: onClick) {
                Image(systemName: "xmark")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
            }
            .buttonStyle(.plain)

            Text(ingredient.strIngredient)
                .font(.subheadline)
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray))
        .clipShape(Capsule())
    }
}

#Preview {
    HStack {
        IngredientSmallCardView(
            ingredient: Ingredient(
                idIngredient: "1",
                strIngredient: "Chicken",
                strDescription: nil,
                strThumb: nil,
                strType: nil
            ),
            onClick: {}
        )
        IngredientSmallCardView(
            ingredient: Ingredient(
                idIngredient: "2",
                strIngredient: "Worcestershire Sauce",
                strDescription: nil,
                strThumb: nil,
                strType: nil
            ),
            onClick: {}
        )
    }
    .padding()
}
