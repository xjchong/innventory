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
	private enum Constants {
		static let cornerRadiusFactor: CGFloat = 10
		static let shadowRadiusFactor: CGFloat = 5
		static let shadowOpacity: Float = 0.2
	}
	
	@IBOutlet weak var roundCardView: UIView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var playerClassLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	private let disposeBag = DisposeBag()
}


// MARK: - LifeCycle

extension CardCollectionViewCell {
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let cornerRadius: CGFloat = bounds.width/Constants.cornerRadiusFactor
		
		layer.masksToBounds = false
		layer.cornerRadius = cornerRadius
		layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
		layer.shadowRadius = cornerRadius/Constants.shadowRadiusFactor
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = Constants.shadowOpacity
		layer.shadowOffset = CGSize(width: 0, height: 0)
		
		roundCardView.layer.masksToBounds = false
		roundCardView.layer.cornerRadius = cornerRadius
	}
	
	func bind(to viewModel: CardCollectionCellViewModel) {
		disposeBag.dispose()
		
		viewModel.name.bind(to: nameLabel.reactive.text).dispose(in: disposeBag)
		viewModel.type.bind(to: typeLabel.reactive.text).dispose(in: disposeBag)
		viewModel.playerClass.bind(to: playerClassLabel.reactive.text).dispose(in: disposeBag)
		viewModel.image.bind(to: imageView.reactive.image).dispose(in: disposeBag)
		
		viewModel.getImage()
	}
}

