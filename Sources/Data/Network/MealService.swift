//
//  MealService.swift
//  CulinarApp
//
//  Created by eventya on 02.04.2026.
//

import Foundation

// MARK: - Протокол
// Описывает ЧТО умеет делать сервис, но не КАК
protocol MealAPIServiceProtocol {
    func searchMeals(query: String) async throws -> [Meal]
    func getCategories() async throws -> [Category]
    func getMealsByCategory(_ category: String) async throws -> [Meal]
    func getMealDetail(id: String) async throws -> Meal?
    func getRandomSelection() async throws -> [Meal]
}

// MARK: - Реализация
final class MealAPIService: MealAPIServiceProtocol {
    
    static let shared = MealAPIService()
    private init() {}  // <- важно! приватный init у синглтона
    
    private let base = "https://www.themealdb.com/api/json/v2/9973533"

    func searchMeals(query: String) async throws -> [Meal] {
        let url = URL(string: "\(base)/search.php?s=\(query)")!
        // meals может быть nil если ничего не найдено
        return try await fetch(MealResponse.self, from: url).meals ?? []
    }

    func getCategories() async throws -> [Category] {
        let url = URL(string: "\(base)/categories.php")!
        return try await fetch(CategoryResponse.self, from: url).categories
    }

    func getMealsByCategory(_ category: String) async throws -> [Meal] {
        let url = URL(string: "\(base)/filter.php?c=\(category)")!
        return try await fetch(MealResponse.self, from: url).meals ?? []
    }

    func getMealDetail(id: String) async throws -> Meal? {
        let url = URL(string: "\(base)/lookup.php?i=\(id)")!
        return try await fetch(MealResponse.self, from: url).meals?.first  // массив из 1 элеемнта
    }

    func getRandomSelection() async throws -> [Meal] {
        let url = URL(string: "\(base)/randomselection.php")!
        return try await fetch(MealResponse.self, from: url).meals ?? []
    }

    private func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: - UseCase
// Бизнес-логика приложения. Не знает про сеть — работает только с протоколом
final class UseCaseMain {
    private let repository: MealAPIServiceProtocol

    init(repository: MealAPIServiceProtocol) {
        self.repository = repository
    }

    func getMainInfo() async throws -> ([Category], [Meal]) {
        async let categories = repository.getCategories()
        async let randomMeals = repository.getRandomSelection()
        return try await (categories, randomMeals)  // параллельно!
    }
}
