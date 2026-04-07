//
//  CardPopularDishView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 03.04.2026.
//

import SwiftUI

struct CardPopularDishView: View
{
    let image: String
    let text: String
    private let width: CGFloat

    init(image: String, text: String, width: CGFloat = 132) {
        self.image = image
        self.text = text
        self.width = width
    }

    var body: some View {
        let height = self.width * 3 / 2

        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: self.image)) { phase in
                switch phase {
                case .success(let fetchedImage):
                    fetchedImage
                        .resizable()
                        .scaledToFill()
                default:
                    PreviewRectangle(cornerRadius: 16)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LinearGradient(
                colors: [.black.opacity(0.6), .black.opacity(0.2), .clear],
                startPoint: .bottom,
                endPoint: .top)
            .allowsHitTesting(false)

            Text(self.text)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
                .padding(.horizontal, 10)
                .padding(.bottom, 12)
                .frame(width: self.width - 20)
        }
        .frame(width: self.width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    HStack(spacing: 12) {
        CardPopularDishView(
            image: "https://www.themealdb.com/images/media/meals/1548772567.jpg",
            text: "Migas",
            width: 120
        )

        CardPopularDishView(
            image: "https://www.themealdb.com/images/media/meals/1548772567.jpg",
            text: "15-minute chicken & halloumi burgers",
            width: 120
        )
    }
    .padding()
}
