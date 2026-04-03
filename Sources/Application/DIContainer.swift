//
//  DIContainer.swift
//  CulinarApp
//

import Foundation

@MainActor
final class DIContainer
{
    private lazy var homeRepository: HomeRepository = HomeRepositoryImpl()
    private lazy var homeUseCase: HomeUseCase = HomeUseCaseImpl(repository: self.homeRepository)

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(usecase: self.homeUseCase)
    }
}
