import Observation

@Observable
@MainActor
final class FavoriteViewModel {
    var searchText = ""
    private(set) var allMeals: [Meal] = []
    private var pendingRemoval: Set<String> = []

    var filteredMeals: [Meal] {
        if searchText.isEmpty { return allMeals }
        return allMeals.filter {
            $0.strMeal.localizedCaseInsensitiveContains(searchText)
        }
    }

    func load() {
        FavouritesRepository.shared.seedIfEmpty()
        allMeals = FavouritesRepository.shared.fetchAll()
    }

    func isPendingRemoval(_ meal: Meal) -> Bool {
        pendingRemoval.contains(meal.idMeal)
    }

    func toggle(_ meal: Meal) {
        if isPendingRemoval(meal) {
            pendingRemoval.remove(meal.idMeal)
            FavouritesRepository.shared.save(meal)
        } else {
            pendingRemoval.insert(meal.idMeal)
            FavouritesRepository.shared.delete(meal)
        }
    }
}
