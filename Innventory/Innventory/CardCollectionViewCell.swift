//
//  CardCollectionViewCell.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import UIKit
import ReactiveKit


class CardCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var playerClassLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
}


// MARK: - LifeCycle

extension CardCollectionViewCell {
	func bind(to viewModel: CardCollectionCellViewModel) {
		viewModel.name.bind(to: nameLabel.reactive.text)
		viewModel.type.bind(to: typeLabel.reactive.text)
		viewModel.playerClass.bind(to: playerClassLabel.reactive.text)
		viewModel.image.bind(to: imageView.reactive.image)
	}
}

