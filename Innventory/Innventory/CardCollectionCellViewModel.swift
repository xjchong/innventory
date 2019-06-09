//
//  CardCollectionCellViewModel.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-08.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import ReactiveKit
import Bond


class CardCollectionCellViewModel {
	private enum Constants {
		static let placeholderImage = UIImage(named: "card_image_placeholder")
		static let placeholderBadImage = UIImage(named: "card_image_placeholder_404")
	}
	
	let name = Observable<String?>(nil)
	let type = Observable<CardType?>(nil)
	let playerClass = Observable<PlayerClass?>(nil)
	let imageURLString = Observable<String?>(nil)
	let image = Observable<UIImage?>(nil)
}


// MARK: - Public

extension CardCollectionCellViewModel {
	func configure(with card: Card) {
		name.value = card.name
		type.value = card.type
		playerClass.value = card.playerClass
		imageURLString.value = card.imageURLString
		image.value = Constants.placeholderImage
	}

	func getImage(completion: (() -> Void)? = nil) {
		image.value = Constants.placeholderImage
		
		guard
			let imageURLString = imageURLString.value,
			let imageURL = URL(string: imageURLString)
			else {
				completion?()
				return
		}
		
		URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
			defer { completion?() }
			
			guard let self = self else { return }
			
			guard
				error == nil,
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data
				else {
					self.image.value = Constants.placeholderBadImage
					return
			}
			
			self.image.value = UIImage(data: data)
		}.resume()
	}
}
