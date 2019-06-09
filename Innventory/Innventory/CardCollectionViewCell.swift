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
	enum Strings: String, Localizable {
		case enchantmentLabel
		case heroLabel
		case minionLabel
		case powerLabel
		case spellLabel
		case weaponLabel
		
		case deathKnightLabel
		case dreamLabel
		case druidLabel
		case hunterLabel
		case mageLabel
		case neutralLabel
		case paladinLabel
		case priestLabel
		case rogueLabel
		case shamanLabel
		case warlockLabel
		case warriorLabel
		case whizbangLabel
		
		case unknownLabel
		
		var tableName: String { return "CardCollectionViewCell" }
	}
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
		viewModel.image.bind(to: imageView.reactive.image).dispose(in: disposeBag)
		
		viewModel.type
			.map { type in
				guard let type = type else { return Strings.unknownLabel.localized }
				
				switch type {
				case .enchantment: return Strings.enchantmentLabel.localized
				case .hero: return Strings.heroLabel.localized
				case .minion: return Strings.minionLabel.localized
				case .power: return Strings.powerLabel.localized
				case .spell: return Strings.spellLabel.localized
				case .weapon: return Strings.weaponLabel.localized
				}
			}
			.bind(to: typeLabel.reactive.text)
			.dispose(in: disposeBag)
		
		viewModel.playerClass
			.map { playerClass in
				guard let playerClass = playerClass else { return Strings.unknownLabel.localized }
				
				switch playerClass {
				case .deathKnight: return Strings.deathKnightLabel.localized
				case .dream: return Strings.dreamLabel.localized
				case .druid: return Strings.druidLabel.localized
				case .hunter: return Strings.hunterLabel.localized
				case .mage: return Strings.mageLabel.localized
				case .neutral: return Strings.neutralLabel.localized
				case .paladin: return Strings.paladinLabel.localized
				case .priest: return Strings.priestLabel.localized
				case .rogue: return Strings.rogueLabel.localized
				case .shaman: return Strings.shamanLabel.localized
				case .warlock: return Strings.warlockLabel.localized
				case .warrior: return Strings.warriorLabel.localized
				case .whizbang: return Strings.whizbangLabel.localized
				}
			}
			.bind(to: playerClassLabel.reactive.text)
			.dispose(in: disposeBag)
		
		viewModel.getImage()
	}
}

