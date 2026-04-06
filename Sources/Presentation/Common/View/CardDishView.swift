//
//  CardDishView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct CardDishView: View
{
	let title: String
	let image: String
	let country: String
	let timeMinutes: Int
	let isFavorite: Bool
	let onFavoriteTap: () -> Void

    init(
        title: String,
        image: String,
        country: String,
        timeMinutes: Int,
        isFavorite: Bool,
        onFavoriteTap: @escaping () -> Void
    ) {
        self.title = title
        self.image = image
        self.country = country
        self.timeMinutes = timeMinutes
        self.isFavorite = isFavorite
        self.onFavoriteTap = onFavoriteTap
    }

	var body: some View {
        self.content
	}
}

private extension CardDishView
{
    var content: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                CachedImage(url: URL(string: image))
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .clipped()

                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    metaRow
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }

            favoriteButton
                .padding(16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: Color.black.opacity(0.05), radius: 12, x: 0, y: 6)
    }

	@ViewBuilder
    var favoriteButton: some View {
			Button {
				onFavoriteTap()
			} label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(isFavorite ? Color.red : Color.gray.opacity(0.7))
			}
			.accessibilityLabel("Favorite")
	}

	var metaRow: some View {
		HStack(spacing: 14) {
			HStack(spacing: 6) {
				Image(systemName: "clock")
					.foregroundStyle(.gray.opacity(0.75))
				Text("\(timeMinutes) мин")
					.font(.system(size: 18, weight: .semibold))
					.foregroundStyle(.gray)
			}
            Spacer()
				Text(country)
					.font(.system(size: 18, weight: .semibold))
					.foregroundStyle(.gray)
		}
	}
}

#Preview {
	CardDishView(
		title: "Pancakes",
        image: "https://static.vecteezy.com/system/resources/previews/000/296/081/non_2x/vector-set-of-different-dishes.jpg",
		country: "American",
		timeMinutes: 20,
        isFavorite: true, onFavoriteTap: {}
	)
}
