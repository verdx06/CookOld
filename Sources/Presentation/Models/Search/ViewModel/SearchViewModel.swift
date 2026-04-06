//
//  SearchViewModel.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import Foundation

@Observable
final class SearchViewModel
{
    private(set) var repository: SearchRepository
    private var searchTask: Task<Void, Error>?
    var searchText: String = ""
    var selectedCategory: MealCategory?
    var categoriesState: LoadingState<[MealCategory]> = .idle
    var searchResult: LoadingState<[Meal]> = .idle

    init(repository: SearchRepository) {
        self.repository = repository
        Task {
            await loadCategories()
        }
    }

    func scheduleSearch() {
        searchTask?.cancel()
        searchTask = Task {
            try await Task.sleep(nanoseconds: 500_000_000)
            await searchMeals()
        }
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
        guard searchText.isEmpty == false else {
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
}

extension SearchViewModel
{
    enum LoadingState<T>
    {
        case idle
        case loading
        case success(T)
        case failure
    }
}
