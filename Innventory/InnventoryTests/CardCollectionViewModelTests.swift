//
//  CardCollectionViewModelTests.swift
//  InnventoryTests
//
//  Created by Xavier Chong on 2019-06-09.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import XCTest
@testable import Innventory

class CardCollectionViewModelTests: XCTestCase {
	var cards = [Card(name: "1a", imageURLString: nil, type: nil, playerClass: nil),
				 Card(name: "1b", imageURLString: nil, type: nil, playerClass: nil),
				 Card(name: "2a", imageURLString: nil, type: nil, playerClass: nil)]
	
	var cellViewModels = [CardCollectionCellViewModel]()
	
	override func setUp() {
		cellViewModels = cards.map {
			let cellViewModel = CardCollectionCellViewModel()
			
			cellViewModel.configure(with: $0)
			
			return cellViewModel
		}
	}

	func testEmptyNumberOfItemsInSection() {
		let viewModel = CardCollectionViewModel()
		
		XCTAssertEqual(viewModel.numberOfItemsInSection(0), 0)
	}
	
	func testNumberOfItemsInSection() {
		let viewModel = CardCollectionViewModel()
		
		viewModel.cellViewModels.replace(with: cellViewModels)

		XCTAssertEqual(viewModel.numberOfItemsInSection(0), cellViewModels.count)
	}
	
	func testCellViewModelForIndexPath() {
		let viewModel = CardCollectionViewModel()
		let indexPath = IndexPath(item: 0, section: 0)
		
		viewModel.cellViewModels.replace(with: cellViewModels)
		
		XCTAssertEqual(viewModel.cellViewModel(for: indexPath).name.value, cellViewModels.first?.name.value)
	}
	
	func testPerformSearchNoResults() {
		let viewModel = CardCollectionViewModel()
		let searchTerm = "c"
		
		viewModel.cellViewModels.replace(with: cellViewModels)
		viewModel.searchTerm.value = searchTerm
		viewModel.performSearch()
		
		XCTAssertEqual(viewModel.filteredCellViewModels.count, 0)
	}
	
	func testPerformSearchSomeResults() {
		let viewModel = CardCollectionViewModel()
		let searchTerm = "a"

		viewModel.cellViewModels.replace(with: cellViewModels)
		viewModel.searchTerm.value = searchTerm
		viewModel.performSearch()
		
		XCTAssertEqual(viewModel.filteredCellViewModels.count, 2)
	}
	
	func testPerformSearchAllResults() {
		let viewModel = CardCollectionViewModel()
		let searchTerm: String? = nil
		
		viewModel.cellViewModels.replace(with: cellViewModels)
		viewModel.searchTerm.value = searchTerm
		viewModel.performSearch()
		
		XCTAssertEqual(viewModel.filteredCellViewModels.count, 3)
	}
}
