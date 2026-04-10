//
//  Ingredient.swift
//  CulinarApp
//
//  Created by eventya on 07.04.2026.
//

struct Ingredient: Decodable, Identifiable {
    let idIngredient: String
    let strIngredient: String
    let strDescription: String?
    let strThumb: String?
    let strType: String?

    var id: String { idIngredient }
}

struct IngredientResponse: Decodable {
    let meals: [Ingredient]
}
