//
//  DIContainer.swift
//  CulinarApp
//

import Foundation
import SwiftUI

@MainActor
final class DIContainer
{
    private lazy var network: Network = NetworkService()
    private lazy var favouritesRepository: any FavouritesRepository = SwiftDataFavouritesRepository()
    private(set) lazy var imageLoader = ImageLoader(
        cache: CombinedImageCache(
            memoryCache: NSImageCache(),
            diskCache: FileImageCache()
        ),
        session: URLSession.shared
    )
    private lazy var homeRepository: HomeRepository = HomeRepositoryImpl(network: self.network)
    private lazy var detailRepository: DetailRepository = DetailRepositoryImpl(network: self.network)
    private(set) lazy var homeViewModel = HomeViewModel(
        repository: self.homeRepository,
        favouritesRepository: self.favouritesRepository,
        makeDetailViewModel: { [unowned self] mealId in
            self.makeDetailViewModel(mealId: mealId)
        }
    )
    private(set) lazy var favoriteViewModel = FavoriteViewModel(
        repository: self.favouritesRepository,
        makeDetailViewModel: { [unowned self] mealId in
            self.makeDetailViewModel(mealId: mealId)
        }
    )
    private lazy var searchRepository: SearchRepository = ProcessInfo.processInfo.arguments.contains("--uitesting")
        ? UITestSearchRepository()
        : SearchRepositoryImpl(service: self.network)
    private(set) lazy var searchViewModel = SearchViewModel(
        repository: self.searchRepository,
        makeDetailViewModel: { [unowned self] mealId in
            self.makeDetailViewModel(mealId: mealId)
        }
    )
    private(set) lazy var dishBuilderViewModel = DishBuilderViewModel(
        network: network,
        makeDetailViewModel: { [unowned self] mealId in
            self.makeDetailViewModel(mealId: mealId)
        }
    )

    func makeDetailViewModel(mealId: String) -> DetailViewModel {
        DetailViewModel(
            mealId: mealId,
            repository: self.detailRepository,
            favouriteViewModel: self.favoriteViewModel
        )
    }
}
