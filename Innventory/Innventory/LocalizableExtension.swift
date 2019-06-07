//
//  LocalizableExtension.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//


extension Localizable where Self: RawRepresentable, Self.RawValue == String {
	var localized: String {
		return rawValue.localized(tableName: tableName)
	}
}
