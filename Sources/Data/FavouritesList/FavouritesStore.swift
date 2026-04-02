//
//  FavouritesStore.swift
//  CulinarApp
//
//  Created by eventya on 02.04.2026.
//

import Foundation

@Observable
final class FavouritesStore {
    var likedMeals: [Meal] = []
    var pendingRemoval: [Meal] = []
    
    init(likedMeals: [Meal] = []) {
            self.likedMeals = likedMeals
        }
    
    func toggleRemoval(_ meal: Meal) {
        if isPendingRemoval(meal) {
            pendingRemoval.removeAll { $0.id == meal.id }
            FavouritesRepository.shared.save(meal)
        } else if likedMeals.contains(where: { $0.id == meal.id }) {
            pendingRemoval.append(meal)
            FavouritesRepository.shared.delete(meal)
        }
    }
    
    func applyRemovals() {
        likedMeals.removeAll(where: { likedMeal in pendingRemoval.contains(where: { $0.id == likedMeal.id }) })
        pendingRemoval.removeAll()
    }
    
    func isPendingRemoval(_ meal: Meal) -> Bool {
        return pendingRemoval.contains(where: { $0.id == meal.id })
    }
    
    func isLiked(_ meal: Meal) -> Bool {
        if isPendingRemoval(meal) {
            return false
        }
        for likedMeal in likedMeals where likedMeal.id == meal.id {
            return true
        }
        return false
    }
}
