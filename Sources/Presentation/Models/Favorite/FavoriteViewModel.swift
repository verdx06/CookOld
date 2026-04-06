import Observation

@Observable
@MainActor
final class FavoriteViewModel {
    var searchText = ""
    private(set) var allMeals: [Meal] = []
    private var toBeRemoved: Set<String> = []
    private let repository: any FavouritesRepository

    init(repository: FavouritesRepository) {
        self.repository = repository
    }

    var filteredMeals: [Meal] {
        if searchText.isEmpty { return allMeals }
        return allMeals.filter {
            $0.strMeal.localizedCaseInsensitiveContains(searchText)
        }
    }

    func load() {
        repository.seedIfEmpty()
        allMeals = repository.fetchAll()
    }

    func mealToBeRemoved(_ id: String) -> Bool {
        toBeRemoved.contains(id)
    }

    func toggle(_ meal: Meal) {
        if mealToBeRemoved(meal.idMeal) {
            toBeRemoved.remove(meal.id)
            repository.save(meal)
        } else {
            toBeRemoved.insert(meal.id)
            repository.delete(meal.id)
        }
    }
}
