import Observation
import SwiftUI

// MARK: - Environment

extension EnvironmentValues {
    @Entry var favoriteViewModel: FavoriteViewModel = MainActor.assumeIsolated {
        FavoriteViewModel(repository: StubFavouritesRepository())
    }
}

// MARK: - ViewModel

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

    // MARK: - Liked state

    /// IDs of meals that are currently liked (in DB and not pending removal).
    var likedIDs: Set<String> { Set(allMeals.map(\.idMeal)).subtracting(toBeRemoved) }

    func isLiked(_ id: String) -> Bool { likedIDs.contains(id) }

    /// Returns a copy of `meal` with `isLiked` set from in-memory state.
    func stamped(_ meal: Meal) -> Meal {
        var copy = meal
        copy.isLiked = isLiked(meal.idMeal)
        return copy
    }

    // MARK: - Filtered list (Favorites tab)

    var filteredMeals: [Meal] {
        let sorted = allMeals.sorted { $0.strMeal < $1.strMeal }
        if searchText.isEmpty { return sorted }
        return sorted.filter { $0.strMeal.localizedCaseInsensitiveContains(searchText) }
    }

    func load() {
        allMeals = repository.fetchAll()
        toBeRemoved = []
    }

    func mealToBeRemoved(_ id: String) -> Bool {
        toBeRemoved.contains(id)
    }

    // MARK: - Soft-delete toggle (used by Favorites tab)

    func toggle(_ meal: Meal) {
        if mealToBeRemoved(meal.idMeal) {
            toBeRemoved.remove(meal.id)
            repository.save(meal)
        } else {
            toBeRemoved.insert(meal.id)
            repository.delete(meal.id)
        }
    }

    // MARK: - Direct like/unlike (used by cards outside Favorites tab)

    func like(_ meal: Meal) {
        toBeRemoved.remove(meal.idMeal)
        if allMeals.contains(where: { $0.idMeal == meal.idMeal }) == false {
            var liked = meal
            liked.isLiked = true
            allMeals.append(liked)
        }
        repository.save(meal)
    }

    func unlike(_ id: String) {
        toBeRemoved.remove(id)
        allMeals.removeAll { $0.idMeal == id }
        repository.delete(id)
    }

    func toggleLike(_ meal: Meal) {
        if isLiked(meal.idMeal) {
            unlike(meal.idMeal)
        } else {
            like(meal)
        }
    }
}
