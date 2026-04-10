import SwiftData

@Model
final class FavouriteModel {
    var idMeal: String
    var strMeal: String
    var strMealThumb: String
    var strArea: String?
    var strCategory: String?

    init(from meal: Meal) {
        self.idMeal = meal.idMeal
        self.strMeal = meal.strMeal
        self.strMealThumb = meal.strMealThumb
        self.strArea = meal.strArea
        self.strCategory = meal.strCategory
    }

    func toMeal() -> Meal {
        Meal(
            idMeal: idMeal,
            strMeal: strMeal,
            strMealThumb: strMealThumb,
            strArea: strArea,
            strCategory: strCategory,
            isLiked: true
        )
    }
}
