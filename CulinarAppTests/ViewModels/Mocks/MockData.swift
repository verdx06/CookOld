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
            strMealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
            strArea: "Japanese",
            strCategory: "Chicken",
        ),
        Meal(
            idMeal: "52773",
            strMeal: "Honey Teriyaki Salmon",
            strMealThumb: "https://www.themealdb.com/images/media/meals/xxyupu1468262513.jpg",
            strArea: "Japanese",
            strCategory: "Seafood",
        )
    ]

    static let categories: [MealCategory] = [
        MealCategory(id: "1", name: "Beef", image: URL(string: "https://www.themealdb.com/images/category/beef.png")!),
        MealCategory(id: "2", name: "Chicken", image: URL(string: "https://www.themealdb.com/images/category/chicken.png")!),
        MealCategory(id: "3", name: "Seafood", image: URL(string: "https://www.themealdb.com/images/category/seafood.png")!)
    ]
}
