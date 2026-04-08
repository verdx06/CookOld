//
//  DIContainer.swift
//  CulinarApp
//

import Foundation

@MainActor
final class DIContainer
{
    private lazy var network: Network = NetworkService()
    private lazy var homeRepository: HomeRepository = HomeRepositoryImpl(network: self.network)
    private lazy var homeUseCase: HomeUseCase = HomeUseCaseImpl(repository: self.homeRepository)
    private lazy var homeViewModel = HomeViewModel(usecase: self.homeUseCase)

    func makeHomeViewModel() -> HomeViewModel {
        self.homeViewModel
    }
}
