//
//  SearchViewModel.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import Foundation


@Observable
final class SearchViewModel {
    private var repository: SearchRepository
    private var categorySearchTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?
    var searchText: String = ""
    var selectedCategory: MealCategory? = nil
    var categoriesState: LoadingState<[MealCategory]> = .idle
    var searchResult: LoadingState<[Meal]> = .idle
    var isInCategoryMode: Bool = false

    func scheduleSearch() {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            await searchMeals()
        }
    }
    
    func scheduleCategorySearch(category: MealCategory) {
        categorySearchTask?.cancel()
        categorySearchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            await searchMealsInCategory(category: category)
        }
    }
    
    init(repository: SearchRepository) {
        self.repository = repository
    }
    
    func loadCategories() async {
        categoriesState = .loading
        
        do {
            categoriesState = .success(try await repository.loadCategories())
        } catch {
            categoriesState = .failure
        }
    }

    func searchMeals() async {
        searchResult = .loading
        guard !searchText.isEmpty else {
            searchResult = .idle
            return
        }
        do {
            searchResult = .success(try await repository.searchMeals(name: searchText))
        } catch {
            if (error as NSError).code != NSURLErrorCancelled {
                searchResult = .failure
            }
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


extension SearchViewModel {
    enum LoadingState<T> {
        case idle
        case loading
        case success(T)
        case failure
    }
}
