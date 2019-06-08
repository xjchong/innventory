//
//  NibLoadableViewExtension.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-08.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import UIKit


extension NibLoadableView where Self: UIView {
	static var nibName: String {
		return String(describing: self)
	}
}
