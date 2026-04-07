//
//  MockData.swift
//  CulinarAppTests
//
//  Created by Варя Черепенникова on 07.04.2026.
//

import Foundation
@testable import CulinarApp

enum MockData {
    static let meals: [Meal] = [
        Meal(
            idMeal: "52772",
            strMeal: "Teriyaki Chicken Casserole",
            strMealAlternate: nil,
            strCategory: "Chicken",
            strArea: "Japanese",
            strInstructions: nil,
            strMealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
            strTags: nil,
            strYoutube: nil,
            strIngredient1: "soy sauce", strIngredient2: "water", strIngredient3: "brown sugar",
            strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil,
            strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil,
            strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil,
            strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil,
            strIngredient20: nil,
            strMeasure1: "3/4 cup", strMeasure2: "1/2 cup", strMeasure3: "1/4 cup",
            strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil,
            strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil,
            strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil,
            strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil,
            strMeasure20: nil,
            strSource: nil,
            strImageSource: nil,
            strCreativeCommonsConfirmed: nil,
            dateModified: nil
        ),
        Meal(
            idMeal: "52773",
            strMeal: "Honey Teriyaki Salmon",
            strMealAlternate: nil,
            strCategory: "Seafood",
            strArea: "Japanese",
            strInstructions: nil,
            strMealThumb: "https://www.themealdb.com/images/media/meals/xxyupu1468262513.jpg",
            strTags: nil,
            strYoutube: nil,
            strIngredient1: "salmon", strIngredient2: "honey", strIngredient3: nil,
            strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil,
            strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil,
            strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil,
            strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil,
            strIngredient20: nil,
            strMeasure1: "200g", strMeasure2: "2 tbsp", strMeasure3: nil,
            strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil,
            strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil,
            strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil,
            strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil,
            strMeasure20: nil,
            strSource: nil,
            strImageSource: nil,
            strCreativeCommonsConfirmed: nil,
            dateModified: nil
        )
    ]

    static let categories: [MealCategory] = [
        MealCategory(id: "1", name: "Beef", image: URL(string: "https://www.themealdb.com/images/category/beef.png")!),
        MealCategory(id: "2", name: "Chicken", image: URL(string: "https://www.themealdb.com/images/category/chicken.png")!),
        MealCategory(id: "3", name: "Seafood", image: URL(string: "https://www.themealdb.com/images/category/seafood.png")!)
    ]
}
