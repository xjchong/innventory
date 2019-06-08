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
	enum Strings: String, Localizable {
		case navigationTitle
		case refreshErrorMessage

		var tableName: String { return "CardCollectionViewModel" }
	}
	
	let cellViewModels = MutableObservableArray<CardCollectionCellViewModel>()
	let isLoading = Observable<Bool>(false)
	let errorMessages = SafePublishSubject<String>()
	
	let title = Strings.navigationTitle.localized
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
				self.cellViewModels.replace(with: cards.map {
					let cellViewModel = CardCollectionCellViewModel()
					
					cellViewModel.configure(with: $0)
					
					return cellViewModel
				})
				
				#warning("Remove debug statement")
				print("SUCCESS!")
			case .failure:
				self.errorMessages.next(Strings.refreshErrorMessage.localized)
			}
		}
	}
}
