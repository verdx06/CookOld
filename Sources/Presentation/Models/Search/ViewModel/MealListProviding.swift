//
//  MealListProviding.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 09.04.2026.
//

protocol MealListProviding {
    func detailViewModel(for mealId: String) -> DetailViewModel
}
