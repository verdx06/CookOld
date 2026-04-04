import SwiftData

@Observable
@MainActor
final class SwiftDataFavouritesRepository: FavouritesRepository {

    private let context: ModelContext

    init() {
        // ModelContainer is SwiftData's engine — it sets up the database file on disk.
        // You only tell it which models exist; it handles the rest.
        let container = try! ModelContainer(for: FavouriteModel.self)
        self.context = ModelContext(container)
    }

    // MARK: - Read

    func fetchAll() -> [Meal] {
        let results = (try? context.fetch(FetchDescriptor<FavouriteModel>())) ?? []
        return results.map { $0.toMeal() }
    }

    func contains(_ id: String) -> Bool {
        find(id) != nil
    }

    // MARK: - Write

    func save(_ meal: Meal) {
        guard !contains(meal.idMeal) else { return }
        context.insert(FavouriteModel(from: meal))
        try? context.save()
    }


    func delete(_ id: String) {
        guard let model = find(id) else { return }
        context.delete(model)
        try? context.save()
    }

    // MARK: - Seed

    func resetSeed() {
        let all = (try? context.fetch(FetchDescriptor<FavouriteModel>())) ?? []
        all.forEach { context.delete($0) }
        try? context.save()
        seedIfEmpty()
    }

    func seedIfEmpty() {
        guard fetchAll().isEmpty else { return }

        let meals: [Meal] = [
            Meal(idMeal: "52772", strMeal: "Teriyaki Chicken Casserole", strMealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg", strArea: "Japanese", strCategory: "Chicken"),
            Meal(idMeal: "52795", strMeal: "Chicken Handi", strMealThumb: "https://www.themealdb.com/images/media/meals/wyxwsp1486979827.jpg", strArea: "Indian", strCategory: "Chicken"),
            Meal(idMeal: "52844", strMeal: "Beef Banh Mi Bowls", strMealThumb: "https://www.themealdb.com/images/media/meals/z0ageb1583189517.jpg", strArea: "Vietnamese", strCategory: "Beef"),
            Meal(idMeal: "52959", strMeal: "Baked Salmon with Fennel", strMealThumb: "https://www.themealdb.com/images/media/meals/1548772327.jpg", strArea: "British", strCategory: "Seafood"),
            Meal(idMeal: "53049", strMeal: "Croissant aux Amandes", strMealThumb: "https://www.themealdb.com/images/media/meals/y5ruu61614080982.jpg", strArea: "French", strCategory: "Dessert"),
            Meal(idMeal: "52965", strMeal: "Spaghetti Bolognese", strMealThumb: "https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg", strArea: "Italian", strCategory: "Pasta"),
            Meal(idMeal: "52874", strMeal: "Fettuccine Alfredo", strMealThumb: "https://www.themealdb.com/images/media/meals/uquqtu1511178042.jpg", strArea: "Italian", strCategory: "Pasta"),
            Meal(idMeal: "52893", strMeal: "Chocolate Mousse", strMealThumb: "https://www.themealdb.com/images/media/meals/qxuqtt1511728429.jpg", strArea: "French", strCategory: "Dessert"),
            Meal(idMeal: "52834", strMeal: "Poutine", strMealThumb: "https://www.themealdb.com/images/media/meals/uuyrrx1487327597.jpg", strArea: "Canadian", strCategory: "Miscellaneous"),
            Meal(idMeal: "52856", strMeal: "Shakshuka", strMealThumb: "https://www.themealdb.com/images/media/meals/g373701551450225.jpg", strArea: "Tunisian", strCategory: "Breakfast"),
        ]

        meals.forEach { save($0) }
    }

    // MARK: - Helpers

    private func find(_ id: String) -> FavouriteModel? {
        let all = (try? context.fetch(FetchDescriptor<FavouriteModel>())) ?? []
        return all.first { $0.idMeal == id }
    }
}
