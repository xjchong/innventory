//
//  CardCollectionViewModel.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import ReactiveKit
import Bond


class CardCollectionViewModel {
	let cards = MutableObservableArray<Card>()
	let isLoading = Observable<Bool>(false)
	let errorMessages = SafePublishSubject<String>()
}


// MARK: - Public

extension CardCollectionViewModel {
	func refreshCollection() {
		isLoading.next(true)
		
		CardService.getAllCards { [weak self] result in
			guard let self = self else { return }
			
			self.isLoading.next(false)
			
			switch result {
			case .success(let cards):
				self.cards.replace(with: cards)
			case .failure:
				#warning("Localize error messages")
				self.errorMessages.next("Something went wrong! :(")
			}
		}
	}
}
