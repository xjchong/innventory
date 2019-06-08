//
//  ReusableView.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-08.
//  Copyright © 2019 XJCHONG. All rights reserved.
//


protocol ReusableView: class {
	static var defaultReuseIdentifier: String { get }
}
