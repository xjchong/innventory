//
//  CardCollectionCellViewModelTests.swift
//  InnventoryTests
//
//  Created by Xavier Chong on 2019-06-08.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import XCTest
@testable import Innventory


class CardCollectionCellViewModelTests: XCTestCase {
	var viewModel = CardCollectionCellViewModel()

    override func setUp() {
		viewModel = CardCollectionCellViewModel()
    }

	func testEmptyName() {
		XCTAssertNil(viewModel.name.value)
	}
	
	func testEmptyType() {
		XCTAssertNil(viewModel.type.value)
	}
	
	func testEmptyPlayerClass() {
		XCTAssertNil(viewModel.playerClass.value)
	}
	
	func testEmptyImageBeforeLoad() {
		XCTAssertNil(viewModel.image.value)
	}
	
	func testEmptyImageAfterLoad() {
		viewModel.getImage() { [weak self] in
			guard let self = self else { return }
			
			XCTAssertEqual(self.viewModel.image.value, UIImage(named: "card_image_placeholder"))
		}
	}
	
	func testName() {
		let card = Card(name: "name", imageURLString: nil, type: nil, playerClass: nil)
		
		viewModel.configure(with: card)
		
		XCTAssertEqual(viewModel.name.value, card.name)
	}
	
	func testType() {
		let card = Card(name: "name", imageURLString: nil, type: .enchantment, playerClass: nil)
		
		viewModel.configure(with: card)
		
		XCTAssertEqual(viewModel.type.value, card.type)
	}
	
	func testPlayerClass() {
		let card = Card(name: "name", imageURLString: nil, type: nil, playerClass: .warrior)
		
		viewModel.configure(with: card)
		
		XCTAssertEqual(viewModel.playerClass.value, card.playerClass)
	}
	
	func testBadImage() {
		let card = Card(name: "name", imageURLString: "badImageURLString", type: nil, playerClass: nil)
		
		viewModel.configure(with: card)
		
		viewModel.getImage() { [weak self] in
			guard let self = self else {
				XCTFail()
				return
			}
			
			XCTAssertEqual(self.viewModel.image.value, UIImage(named: "card_image_placeholder"))
		}
	}
}
