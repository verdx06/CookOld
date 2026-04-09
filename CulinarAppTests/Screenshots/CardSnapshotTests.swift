//
//  CardSnapshotTests.swift
//  CulinarAppTests
//
//  Created by Варя Черепенникова on 08.04.2026.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import CulinarApp

final class CardSnapshotTests: XCTestCase
{
    private func makeCardSnapshot<V: View>(_ view: V) -> UIViewController {
        let hosted = view
            .environment(\.imageLoader, MockImageLoader())
            .transaction { $0.animation = nil }
        let vc = UIHostingController(rootView: hosted)
        vc.view.frame = UIScreen.main.bounds

        return vc
    }

    func testCategoryCard() {
        let card = CategoryCard(category: MockData.categories[0])
            .frame(width: 180)
            .padding()
        assertSnapshot(of: makeCardSnapshot(card), as: .image(on: .iPhone13))
    }

    func testCardDishView() {
        let meal = MockData.meals[0]
        let card = CardDishView(
            title: meal.strMeal,
            image: meal.imageURL,
            category: meal.strCategory ?? "",
            area: meal.strArea ?? "",
            isFavorite: false,
            onFavoriteTap: {}
        )
        .padding()
        assertSnapshot(of: makeCardSnapshot(card), as: .image(on: .iPhone13))
    }

    func testCardDishViewFavorite() {
        let meal = MockData.meals[0]
        let card = CardDishView(
            title: meal.strMeal,
            image: meal.imageURL,
            category: meal.strCategory ?? "",
            area: meal.strArea ?? "",
            isFavorite: true,
            onFavoriteTap: {}
        )
        .padding()
        assertSnapshot(of: makeCardSnapshot(card), as: .image(on: .iPhone13))
    }

    func testCardDishViewNoImage() {
        let card = CardDishView(
            title: "Dish without image",
            image: nil,
            category: "Dessert",
            area: "French",
            isFavorite: false,
            onFavoriteTap: {}
        )
        .padding()
        assertSnapshot(of: makeCardSnapshot(card), as: .image(on: .iPhone13))
    }

    func testCardPopularDishView() {
        let card = CardPopularDishView(
            image: "https://example.com/image.jpg",
            text: "Migas"
        )
        .padding()
        assertSnapshot(of: makeCardSnapshot(card), as: .image(on: .iPhone13))
    }
}
