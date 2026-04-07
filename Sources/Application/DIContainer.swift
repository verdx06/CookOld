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

    private lazy var detailRepository: DetailRepository = DetailRepositoryImpl(network: self.network)
    private lazy var detailUseCase: DetailUseCase = DetailUseCaseImpl(repository: self.detailRepository)

    private lazy var searchRepository: SearchRepository = SearchRepositoryImpl(service: self.network)
    private lazy var searchViewModel = SearchViewModel(repository: self.searchRepository)

    private lazy var imageLoader: ImageLoader = ImageLoaderImpl(
        cache: CombinedImageCache(
            memoryCache: NSImageCache(),
            diskCache: FileImageCache()
        ),
        session: URLSession.shared
    )
    func makeHomeViewModel() -> HomeViewModel {
        self.homeViewModel
    }

    func makeDetailViewModel(mealId: String) -> DetailViewModel {
        DetailViewModel(mealId: mealId, usecase: self.detailUseCase)
    }

    func makeSearchViewModel() -> SearchViewModel {
        self.searchViewModel
    }

    func makeImageLoader() -> ImageLoader {
        self.imageLoader
    }
}
