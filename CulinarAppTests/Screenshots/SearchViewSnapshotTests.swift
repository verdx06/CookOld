//
//  SearchViewSnapshotTests.swift
//  CulinarAppTests
//
//  Created by Варя Черепенникова on 07.04.2026.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import CulinarApp

final class SearchViewSnapshotTests: XCTestCase {
    private func makeVM(
        categoriesState: SearchViewModel.LoadingState<[MealCategory]> = .idle,
        searchResult: SearchViewModel.LoadingState<[Meal]> = .idle,
        searchText: String = ""
    ) -> SearchViewModel {
        let vm = SearchViewModel(repository: MockSearchRepository())
        vm.categoriesState = categoriesState
        vm.searchResult = searchResult
        vm.searchText = searchText
        return vm
    }

    private func makeSnapshot(_ vm: SearchViewModel) -> UIViewController {
        let view = SearchView(viewModel: vm)
            .environment(\.imageLoader, MockImageLoader())
            .transaction { $0.animation = nil }
        let vc = UIHostingController(rootView: view)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }

    func testCategoriesLoading() {
        let vc = makeSnapshot(makeVM(categoriesState: .loading))
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }

    func testCategoriesLoaded() {
        let vc = makeSnapshot(makeVM(categoriesState: .success(MockData.categories)))
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }

    func testCategoriesFailure() {
        let vc = makeSnapshot(makeVM(categoriesState: .failure))
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }

    func testSearchLoading() {
        let vc = makeSnapshot(makeVM(
            categoriesState: .success(MockData.categories),
            searchResult: .loading,
            searchText: "chicken"
        ))
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }

    func testSearchResultsFound() {
        let vc = makeSnapshot(makeVM(
            categoriesState: .success(MockData.categories),
            searchResult: .success(MockData.meals),
            searchText: "chicken"
        ))
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }

    func testSearchResultsEmpty() {
        let vc = makeSnapshot(makeVM(
            categoriesState: .success(MockData.categories),
            searchResult: .success([]),
            searchText: "zzz"
        ))
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }

    func testSearchFailure() {
        let vc = makeSnapshot(makeVM(
            categoriesState: .success(MockData.categories),
            searchResult: .failure,
            searchText: "chicken"
        ))
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }
}
