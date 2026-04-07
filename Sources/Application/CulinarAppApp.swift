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
    private let imageLoader = ImageLoader(
        cache: CombinedImageCache(
            memoryCache: NSImageCache(),
            diskCache: FileImageCache()
        ),
        session: URLSession.shared
    )

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.imageLoader, imageLoader)
        }
    }
}
