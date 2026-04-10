import Foundation
@testable import CulinarApp

@MainActor
final class MockFavouritesRepository: FavouritesRepository
{
    private(set) var meals: [Meal]

    private(set) var fetchAllCalls = 0
    private(set) var saveCalls = 0
    private(set) var deleteCalls = 0
    private(set) var resetSeedCalls = 0
    private(set) var seedIfEmptyCalls = 0

    private(set) var savedMeals: [Meal] = []
    private(set) var deletedIds: [String] = []

    init(meals: [Meal] = []) {
        self.meals = meals
    }

    func fetchAll() -> [Meal] {
        fetchAllCalls += 1
        return meals
    }

    func save(_ meal: Meal) {
        saveCalls += 1
        savedMeals.append(meal)

        meals.removeAll { $0.idMeal == meal.idMeal }
        meals.append(meal)
    }

    func delete(_ id: String) {
        deleteCalls += 1
        deletedIds.append(id)
        meals.removeAll { $0.idMeal == id }
    }

    func resetSeed() {
        resetSeedCalls += 1
    }

    func seedIfEmpty() {
        seedIfEmptyCalls += 1
    }
}

