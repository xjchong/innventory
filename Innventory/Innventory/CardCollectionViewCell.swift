//
//  CardCollectionViewCell.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import UIKit
import ReactiveKit


class CardCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var playerClassLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	private let disposeBag = DisposeBag()
}


// MARK: - LifeCycle

extension CardCollectionViewCell {
	func bind(to viewModel: CardCollectionCellViewModel) {
		disposeBag.dispose()
		
		viewModel.name.bind(to: nameLabel.reactive.text).dispose(in: disposeBag)
		viewModel.type.bind(to: typeLabel.reactive.text).dispose(in: disposeBag)
		viewModel.playerClass.bind(to: playerClassLabel.reactive.text).dispose(in: disposeBag)
		viewModel.image.bind(to: imageView.reactive.image).dispose(in: disposeBag)
		
		viewModel.getImage()
	}
}

