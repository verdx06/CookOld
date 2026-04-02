//
//  FavoriteView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct FavoriteView: View
{
    var body: some View {
        VStack {
            HStack {
                Text("favourite_title".localized())
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    FavoriteView()
}
