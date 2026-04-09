//
//  DetailViewModelTests.swift
//  CulinarAppTests
//
//  Created by Виталий Багаутдинов on 09.04.2026.
//

import XCTest
@testable import CulinarApp

@MainActor
final class DetailViewModelTests: XCTestCase
{
    func testLoadContentEndsInLoadedAndFetchesDetails() async {
        let meal = Meal(idMeal: "1", strMeal: "Test meal", strMealThumb: "https://example.com/a.jpg")
        let sut = makeSUT(result: .success(meal))

        await sut.viewModel.loadContent()

        XCTAssertEqual(sut.viewModel.contentState, .loaded)
        XCTAssertEqual(sut.repository.getMealDetailsCallCount, 1)
        XCTAssertEqual(sut.repository.requestedIds, ["1"])
        XCTAssertEqual(sut.viewModel.meal?.idMeal, "1")
        XCTAssertEqual(sut.favouritesRepository.fetchAllCalls, 2)
    }

    func testLoadContentWhenNotIdleDoesNotFetch() async {
        let meal = Meal(idMeal: "1", strMeal: "Test meal", strMealThumb: "https://example.com/a.jpg")
        let sut = makeSUT(result: .success(meal))
        sut.viewModel.contentState = .loaded

        await sut.viewModel.loadContent()

        XCTAssertEqual(sut.repository.getMealDetailsCallCount, 0)
        XCTAssertEqual(sut.favouritesRepository.fetchAllCalls, 1)
    }

    func testRetryWhenDetailsFailSetsFailedState() async {
        let error = NSError(
            domain: "DetailViewModelTests",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Test error"]
        )
        let sut = makeSUT(result: .failure(error))

        await sut.viewModel.retry()

        XCTAssertEqual(sut.viewModel.contentState, .failed("Test error"))
        XCTAssertEqual(sut.repository.getMealDetailsCallCount, 1)
        XCTAssertEqual(sut.repository.requestedIds, ["1"])
        XCTAssertEqual(sut.favouritesRepository.fetchAllCalls, 1)
    }
}

private extension DetailViewModelTests
{
    func makeSUT(
        result: Result<Meal, Error>
    ) -> (viewModel: DetailViewModel, repository: MockDetailRepository, favouritesRepository: MockFavouritesRepository) {
        let repository = MockDetailRepository()
        repository.result = result
        let favouritesRepository = MockFavouritesRepository()
        let viewModel = DetailViewModel(
            mealId: "1",
            repository: repository,
            favouritesRepository: favouritesRepository
        )
        return (viewModel, repository, favouritesRepository)
    }
}
