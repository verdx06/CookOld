//
//  SearchViewModel.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI
import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case success(T)
    case failure
}

@Observable
final class SearchViewModel {
    var searchText: String = ""
    var selectedCategory: MealCategory? = nil
    var categoriesState: LoadingState<[MealCategory]> = .idle
    var searchResult: LoadingState<[Meal]> = .idle
    
    func loadCategories() async {
        categoriesState = .loading
        
        do {
            let url = URL(string: "https://www.themealdb.com/api/json/v2/9973533/categories.php")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            categoriesState = .success(response.categories)
        } catch {
            categoriesState = .failure
        }
    }
    
    func searchMeals() async {}
    
    func searchMealsByCategories(category: MealCategory) async {}
    
}


