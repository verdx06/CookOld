//
//  CulinarAppApp.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 31.03.2026.
//

import SwiftUI

@main
struct CulinarAppApp: App
{
    private let diContainer = DIContainer()
    private let imageLoader = ImageLoader(
        cache: CombinedImageCache(
            memoryCache: NSImageCache(),
            diskCache: FileImageCache()
        ),
        session: URLSession.shared
    )

    var body: some Scene {
        WindowGroup {
            MainView(diContainer: self.diContainer)
                .environment(\.imageLoader, imageLoader)
        }
    }
}
