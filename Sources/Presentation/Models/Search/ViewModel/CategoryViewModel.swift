//
//  CategoryViewModel.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 04.04.2026.
//

import Foundation

@Observable
final class CategoryViewModel {
    private var repository: SearchRepository
    private var searchTask: Task<Void, Never>?
    var searchText: String = ""
    var searchResult: LoadingState<[Meal]> = .idle
    
    init(repository: SearchRepository) {
        self.repository = repository
    }
    
    func scheduleSearch(category: MealCategory) {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            await searchMealsInCategory(category: category)
        }
    }
    
    func searchMealsByCategories(category: MealCategory) async {
        searchResult = .loading
        do {
            searchResult = .success(try await repository.searchMealsByCategories(category: category))
        } catch {
            if (error as NSError).code != NSURLErrorCancelled {
                searchResult = .failure
            }
        }
    }
    
    func searchMealsInCategory(category: MealCategory) async {
        searchResult = .loading
        guard !searchText.isEmpty else {
            await searchMealsByCategories(category: category)
            return
        }
        do {
            searchResult = .success(try await repository.searchMealsInCategory(name: searchText, category: category))
        } catch {
            if (error as NSError).code != NSURLErrorCancelled {
                searchResult = .failure
            }
        }
    }
}

extension CategoryViewModel {
    enum LoadingState<T> {
        case idle
        case loading
        case success(T)
        case failure
    }
}
