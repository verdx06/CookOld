//
//  CategoryViewModel.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 04.04.2026.
//

import Foundation

@Observable
final class CategoryViewModel
{
    private var repository: SearchRepository
    private var searchTask: Task<Void, Error>?
    let selectedCategory: MealCategory
    var searchText: String = "" {
        didSet { scheduleSearch() }
    }
    var searchResult: LoadingState<[Meal]> = .idle

    init(selectedCategory: MealCategory, repository: SearchRepository) {
        self.selectedCategory = selectedCategory
        self.repository = repository
    }

    func scheduleSearch() {
        searchTask?.cancel()
        searchTask = Task {
            try await Task.sleep(nanoseconds: 500_000_000)
            await searchMealsInCategory()
        }
    }

    func searchMealsByCategories() async {
        searchResult = .loading
        do {
            searchResult = .success(try await repository.searchMealsByCategories(category: selectedCategory))
        } catch {
            if (error as NSError).code != NSURLErrorCancelled {
                searchResult = .failure
            }
        }
    }

    func searchMealsInCategory() async {
        searchResult = .loading
        guard searchText.isEmpty == false else {
            await searchMealsByCategories()
            return
        }
        do {
            searchResult = .success(try await repository.searchMealsInCategory(
                name: searchText,
                category: selectedCategory
            ))
        } catch {
            if (error as NSError).code != NSURLErrorCancelled {
                searchResult = .failure
            }
        }
    }
}

extension CategoryViewModel
{
    enum LoadingState<T>
    {
        case idle
        case loading
        case success(T)
        case failure
    }
}
