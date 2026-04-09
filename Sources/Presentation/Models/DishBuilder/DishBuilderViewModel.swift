//
//  DishBuilderViewModel.swift
//  CulinarApp
//
//  Created by eventya on 07.04.2026.
//
import Observation
import Foundation

@Observable
@MainActor
final class DishBuilderViewModel {
    var searchText = ""
    var showCooked = false
    private(set) var chosen: Set<String> = []
    private(set) var state: ResponseStates = .empty
    let network: Network

    init(network: Network) {
        self.network = network
    }

    var chosenIngredients: [Ingredient] {
        filteredSorted.filter { chosen.contains($0.id) }
    }

    var allChosenIngredients: [String] {
        state.allIngredients
            .filter { chosen.contains($0.id) }
            .map { $0.strIngredient }
    }

    var availableIngredients: [Ingredient] {
        filteredSorted.filter { chosen.contains($0.id) == false }
    }

    private var filteredSorted: [Ingredient] {
        let list = state.allIngredients.sorted { $0.strIngredient < $1.strIngredient }
        guard searchText.isEmpty == false else { return list }
        return list.filter { $0.strIngredient.localizedCaseInsensitiveContains(searchText) }
    }

    func toggle(_ ingredient: Ingredient) {
        if chosen.contains(ingredient.id) {
            chosen.remove(ingredient.id)
        } else {
            chosen.insert(ingredient.id)
        }
    }

    func load() {
        guard state.allIngredients.isEmpty else { return }
        Task { await fetch() }
    }

    func reload() async {
        await fetch()
    }

    private func fetch() async {
        guard state.isLoading == false else { return }
        do {
            let response: IngredientResponse = try await network.requestData(
                url: "/list.php",
                params: ["i": "list"]
            )
            state = .success(response.meals)
        } catch {
            state = .failure(error)
        }
    }

    enum ResponseStates {
        case success([Ingredient])
        case loading
        case failure(Error)
        case empty

        var isLoading: Bool {
            if case .loading = self { return true }
            return false
        }

        var allIngredients: [Ingredient] {
            if case .success(let ingredients) = self { return ingredients }
            return []
        }
    }
//
//    private func findMealsByIngredients() async throws {
//        let response: MealResponse = try await network.requestData(
//                url: "/filter.php",
//                params: ["i": allChosenIngredients.joined(
//                    separator: ","
//                )]
//            )
//        
//        p
//    }

}

extension DishBuilderViewModel {
    func preview(ingredients: [Ingredient], chosen: Set<String>) {
        state = .success(ingredients)
        self.chosen = chosen
    }
}
