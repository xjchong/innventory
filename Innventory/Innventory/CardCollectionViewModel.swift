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
	enum Error {
		case refreshError
	}
	
	let cellViewModels = MutableObservableArray<CardCollectionCellViewModel>()
	let filteredCellViewModels = MutableObservableArray<CardCollectionCellViewModel>()
	let searchTerm = Observable<String?>(nil)
	let isLoading = Observable<Bool>(false)
	let isSearching = Observable<Bool>(false)
	let errors = SafePublishSubject<Error>()
	
	private let disposeBag = DisposeBag()
	
	init() {
		cellViewModels.observeNext { [weak self] _ in
			guard let self = self else { return }
			
			self.filterCellViewModels(by: self.searchTerm.value)
		}.dispose(in: disposeBag)
	}
}


// MARK: - Public

extension CardCollectionViewModel {
	func numberOfItemsInSection(_ section: Int) -> Int {
		return filteredCellViewModels.count
	}
	
	func cellViewModel(for indexPath: IndexPath) -> CardCollectionCellViewModel {
		return filteredCellViewModels[indexPath.item]
	}
	
	@objc func refreshCollection() {
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
			case .failure:
				self.errors.next(.refreshError)
			}
		}
	}
	
	func toggleSearch() {
		isSearching.value = !isSearching.value
		searchTerm.value = nil
		filterCellViewModels(by: nil)
	}
	
	func performSearch() {
		filterCellViewModels(by: searchTerm.value)
	}
}


// MARK: - Private

private extension CardCollectionViewModel {
	func filterCellViewModels(by searchTerm: String?) {
		if let searchTerm = searchTerm, !searchTerm.isBlank() {
			filteredCellViewModels.replace(with: cellViewModels.array.filter {
				guard let name = $0.name.value else { return false }
				
				return name.lowercased().contains(searchTerm.lowercased())
			})
		} else {
			filteredCellViewModels.replace(with: cellViewModels.array)
		}
	}
}
