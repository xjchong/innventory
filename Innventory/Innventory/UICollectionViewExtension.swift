//
//  UICollectionViewExtension.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-08.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import UIKit


extension UICollectionView {
	func register<CellClass: UICollectionViewCell>(_: CellClass.Type) where CellClass: ReusableView {
		register(CellClass.self, forCellWithReuseIdentifier: CellClass.defaultReuseIdentifier)
	}
	
	func register<CellClass: UICollectionViewCell>(_ : CellClass.Type) where CellClass: ReusableView, CellClass: NibLoadableView {
		let bundle = Bundle(for: CellClass.self)
		let nib = UINib(nibName: CellClass.nibName, bundle: bundle)
		
		register(nib, forCellWithReuseIdentifier: CellClass.defaultReuseIdentifier)
	}
	
	func dequeueReusableCell<CellClass: UICollectionViewCell>(for indexPath: IndexPath) -> CellClass where CellClass: ReusableView {
		guard let cell = dequeueReusableCell(withReuseIdentifier: CellClass.defaultReuseIdentifier, for: indexPath) as? CellClass else {
			fatalError("Could no dequeue cell with identifier: \(CellClass.defaultReuseIdentifier)")
		}
		
		return cell
	}
}
