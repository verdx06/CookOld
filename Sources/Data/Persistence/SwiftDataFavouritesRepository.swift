import SwiftData
import SwiftUI

extension EnvironmentValues {
    @Entry var favouritesRepository: FavouritesRepository = StubFavouritesRepository()
}

// MARK: - Stub
final class StubFavouritesRepository: FavouritesRepository {
    nonisolated init() {}
    func fetchAll() -> [Meal] { [] }
    func save(_ meal: Meal) {}
    func delete(_ id: String) {}
    func resetSeed() {}
    func seedIfEmpty() {}
}

@MainActor
final class SwiftDataFavouritesRepository: FavouritesRepository {

    private let context: ModelContext

    init() {
        // ModelContainer is SwiftData's engine — it sets up the database file on disk.
        // You only tell it which models exist; it handles the rest.
        do {
            let container = try ModelContainer(for: FavouriteModel.self)
            self.context = ModelContext(container)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
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
        guard contains(meal.idMeal) == false else { return }
        context.insert(FavouriteModel(from: meal))
        try? context.save()
    }

    func delete(_ id: String) {
        guard let model = find(id) else { return }
        context.delete(model)
        try? context.save()
    }

    // MARK: - Helpers

    private func find(_ id: String) -> FavouriteModel? {
        let all = (try? context.fetch(FetchDescriptor<FavouriteModel>())) ?? []
        return all.first { $0.idMeal == id }
    }
}
