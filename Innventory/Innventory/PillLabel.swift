//
//  PillLabel.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-09.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import UIKit


@IBDesignable class PillLabel: UILabel {
	@IBInspectable var verticalPadding: CGFloat = 0
	@IBInspectable var horizontalPadding: CGFloat = 0
	
	override var intrinsicContentSize: CGSize {
		let width = super.intrinsicContentSize.width + super.intrinsicContentSize.height + (horizontalPadding*2)
		let height = super.intrinsicContentSize.height + (verticalPadding*2)
		
		return  CGSize(width: width, height: height)
	}
}


// MARK: - LifeCycle

extension PillLabel {
	override func layoutSubviews() {
		super.layoutSubviews()
		
		layer.cornerRadius = frame.height/2
		clipsToBounds = true
		textAlignment = .center
	}
}
