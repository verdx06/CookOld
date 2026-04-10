//
//  CategoryFilterViewSnapshotTests.swift
//  CulinarAppTests
//
//  Created by Варя Черепенникова on 08.04.2026.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import CulinarApp

@MainActor
final class CategoryFilterViewSnapshotTests: XCTestCase {

    private let category = MockData.categories[0]

    private func makeMockDetailViewModel(_ mealId: String) -> DetailViewModel {
        DetailViewModel(
            mealId: mealId,
            repository: MockDetailRepository(),
            favouritesRepository: MockFavouritesRepository()
        )
    }

    private func makeVM(
        searchResult: CategoryViewModel.LoadingState<[Meal]> = .idle,
        searchText: String = "",
    ) -> CategoryViewModel {
        let vm = CategoryViewModel(
            selectedCategory: category,
            repository: MockSearchRepository(),
            makeDetailViewModel: makeMockDetailViewModel
        )
        vm.searchResult = searchResult
        vm.searchText = searchText
        return vm
    }

    private func makeSnapshot(_ vm: CategoryViewModel) -> UIViewController {
        let view = CategoryFilterView(viewModel: vm)
            .environment(\.imageLoader, MockImageLoader())
            .environment(\.disableEntryAnimation, true)
            .transaction { $0.animation = nil }
        let vc = UIHostingController(rootView: view)
        return vc
    }

    func testLoading() {
        let vc = makeSnapshot(makeVM(
            searchResult: .loading,
        ))
        assertSnapshot(of: vc, as: .image(precision: 0.98, perceptualPrecision: 0.98))
    }

    func testResultsFound() {
        let vc = makeSnapshot(makeVM(
            searchResult: .success(MockData.meals)
        ))
        assertSnapshot(of: vc, as: .image(precision: 0.98, perceptualPrecision: 0.98))
    }

    func testResultsEmpty() {
        let vc = makeSnapshot(makeVM(
            searchResult: .success([]),
        ))
        assertSnapshot(of: vc, as: .image(precision: 0.98, perceptualPrecision: 0.98))
    }

    func testFailure() {
        let vc = makeSnapshot(makeVM(
            searchResult: .failure,
        ))
        assertSnapshot(of: vc, as: .image(precision: 0.98, perceptualPrecision: 0.98))
    }
    
    func testSearchCatgoryLoading() {
        let vc = makeSnapshot(makeVM(
            searchResult: .loading,
            searchText: "chicken"
        ))
        assertSnapshot(of: vc, as: .image(precision: 0.98, perceptualPrecision: 0.98))
    }

    func testSearchCatgoryResultsFound() {
        let vc = makeSnapshot(makeVM(
            searchResult: .success(MockData.meals),
            searchText: "chicken"
        ))
        assertSnapshot(of: vc, as: .image(precision: 0.98, perceptualPrecision: 0.98))
    }

    func testSearchCatgoryResultsEmpty() {
        let vc = makeSnapshot(makeVM(
            searchResult: .success([]),
            searchText: "zzz"
        ))
        assertSnapshot(of: vc, as: .image(precision: 0.98, perceptualPrecision: 0.98))
    }

    func testSearchCatgoryFailure() {
        let vc = makeSnapshot(makeVM(
            searchResult: .failure,
            searchText: "chicken"
        ))
        assertSnapshot(of: vc, as: .image(precision: 0.98, perceptualPrecision: 0.98))
    }
}
