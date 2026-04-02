//
//  SearchViewModel.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI
import Foundation

//protocol SearchUseCaseProtocol {
//    func loadCategories() async throws -> [MealCategory]
//    func searchMeals(query: String) async throws -> [Meal]
//}

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
    //let remoteCategories: () -> [MealCategory]
    
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
    
    func searchMeals() async {
        searchResult = .loading
        let mockResult = [
            Meal(idMeal: "1", strMeal: "Pasta Carbonara", strMealAlternate: nil, strCategory: "Pasta", strArea: "Italian", strInstructions: "Cook pasta...", strMealThumb: "", strTags: nil, strYoutube: nil, strIngredient1: "Pasta", strIngredient2: "Eggs", strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "200g", strMeasure2: "2", strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil),
            Meal(idMeal: "2", strMeal: "Chicken Tikka", strMealAlternate: nil, strCategory: "Chicken", strArea: "Indian", strInstructions: "Marinate chicken...", strMealThumb: "", strTags: nil, strYoutube: nil, strIngredient1: "Chicken", strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "500g", strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil)
        ]
        
        do {
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            searchResult = .success(mockResult)
        } catch {
            // задача отменена
        }
    }
    
    func searchMealsByCategories(category: MealCategory) async {
        searchResult = .loading
        let mockResult = [
            Meal(idMeal: "1", strMeal: "Pasta Carbonara", strMealAlternate: nil, strCategory: "Pasta", strArea: "Italian", strInstructions: "Cook pasta...", strMealThumb: "", strTags: nil, strYoutube: nil, strIngredient1: "Pasta", strIngredient2: "Eggs", strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "200g", strMeasure2: "2", strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil),
            Meal(idMeal: "2", strMeal: "Chicken Tikka", strMealAlternate: nil, strCategory: "Chicken", strArea: "Indian", strInstructions: "Marinate chicken...", strMealThumb: "", strTags: nil, strYoutube: nil, strIngredient1: "Chicken", strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "500g", strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil)
        ]
        
        do {
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            searchResult = .success(mockResult)
        } catch {
            // задача отменена
        }
        
        // TODO: Разобраться с подключением симулятора
//        do {
//            let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let response = try JSONDecoder().decode(CategoriesResponse.self, from: data)
//            categoriesState = .success(response.categories)
//        } catch {
//            categoriesState = .failure
//        }
    }
    
    
    
}


