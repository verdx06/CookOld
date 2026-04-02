//
//  MealCategory.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import Foundation

struct MealCategory: Identifiable, Decodable  {
    let id: String
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case image = "strCategoryThumb"
    }
}


struct CategoriesResponse: Decodable {
    let categories: [MealCategory]
}
