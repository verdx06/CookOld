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
        let (popular, recent) = sut.useCase.callCounts()
        XCTAssertEqual(popular, 1)
        XCTAssertEqual(recent, 1)
    }

    func testLoadContentWhenNotIdleDoesNotFetch() async {
        let sut = makeSUT()
        sut.viewModel.contentState = .loaded

        await sut.viewModel.loadContent()

        let (popular, recent) = sut.useCase.callCounts()
        XCTAssertEqual(popular, 0)
        XCTAssertEqual(recent, 0)
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
    ) -> (viewModel: HomeViewModel, useCase: MockHomeUseCase) {
        let useCase = MockHomeUseCase(
            popularResult: popularResult,
            recentResult: recentResult
        )
        return (HomeViewModel(usecase: useCase), useCase)
    }
}
