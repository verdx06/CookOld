//
//  HomeViewModelTests.swift
//  CulinarAppTests
//
//  Created by Виталий Багаутдинов on 06.04.2026.
//

import XCTest
@testable import CulinarApp

@MainActor
final class HomeViewModelTests: XCTestCase {
    func testLoadContentEndsInLoadedAndFetchesBoth() async {
        let sut = makeSUT()

        await sut.viewModel.loadContent()

        XCTAssertEqual(sut.viewModel.contentState, .loaded)
        XCTAssertEqual(sut.repository.popularCalls, 1)
        XCTAssertEqual(sut.repository.recentCalls, 1)
    }

    func testLoadContentWhenNotIdleDoesNotFetch() async {
        let sut = makeSUT()
        sut.viewModel.contentState = .loaded

        await sut.viewModel.loadContent()

        XCTAssertEqual(sut.repository.popularCalls, 0)
        XCTAssertEqual(sut.repository.recentCalls, 0)
    }

    func testRetryWhenPopularFailsSetsFailedState() async {
        let error = NSError(
            domain: "HomeViewModelTests",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Test error"]
        )
        let sut = makeSUT(
            popularResult: .failure(error),
            recentResult: .success(MealResponse(meals: nil))
        )

        await sut.viewModel.retry()

        XCTAssertEqual(sut.viewModel.contentState, .failed("Test error"))
    }

    private func makeSUT(
        popularResult: Result<MealResponse, Error> = .success(MealResponse(meals: nil)),
        recentResult: Result<MealResponse, Error> = .success(MealResponse(meals: nil))
    ) -> (viewModel: HomeViewModel, repository: MockHomeRepository) {
        let repository = MockHomeRepository(
            popularResult: popularResult,
            recentResult: recentResult
        )
        let viewModel = HomeViewModel(
            repository: repository,
            makeDetailViewModel: { _ in
                fatalError("DetailViewModel factory not needed for these tests")
            }
        )
        return (viewModel, repository)
    }
}
