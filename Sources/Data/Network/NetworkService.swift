//
//  Network.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 02.04.2026.
//

import Foundation

protocol Network {
    func request<T: Decodable>(url: String) async throws -> T
    
    func requestData<T: Decodable>(url: String, params: [String: String]) async throws -> T
}


final class NetworkService : Network {
    private var baseURL = "https://www.themealdb.com/api/json/v2/9973533"
    
    func request<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: baseURL + url) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func requestData<T: Decodable>(url: String, params: [String: String]) async throws -> T {
        var components = URLComponents(string: baseURL + url)!
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let finalURL = components.url else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: finalURL)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

