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

        sut.viewModel.loadContent()
        await self.waitForContentState(of: sut.viewModel, toBe: .loaded)

        XCTAssertEqual(sut.viewModel.contentState, .loaded)
        XCTAssertEqual(sut.repository.popularCalls, 1)
        XCTAssertEqual(sut.repository.recentCalls, 1)
    }

    func testLoadContentWhenNotIdleDoesNotFetch() async {
        let sut = makeSUT()
        sut.viewModel.contentState = .loaded

        sut.viewModel.loadContent()

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

        sut.viewModel.retry()
        await self.waitForContentState(of: sut.viewModel, toBe: .failed("Test error"))

        XCTAssertEqual(sut.viewModel.contentState, .failed("Test error"))
    }
}

private extension HomeViewModelTests
{
    func waitForContentState(
        of viewModel: HomeViewModel,
        toBe expectedState: HomeViewModel.State,
        timeoutNanoseconds: UInt64 = 1_000_000_000
    ) async {
        let timeoutTask = Task {
            try? await Task.sleep(nanoseconds: timeoutNanoseconds)
        }

        while viewModel.contentState != expectedState, timeoutTask.isCancelled == false {
            await Task.yield()
            try? await Task.sleep(nanoseconds: 10_000_000)
        }

        timeoutTask.cancel()

        if viewModel.contentState != expectedState {
            XCTFail("Timed out waiting for state \(expectedState), current: \(viewModel.contentState)")
        }
    }

    func makeSUT(
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
