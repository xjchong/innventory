//
//  UIAlertControllerExtension.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import UIKit


extension UIAlertController {
	private enum Strings: String, Localizable {
		case errorAlertTitle
		case okActionTitle
		
		var tableName: String { return String(describing: self) }
	}
	
	class func error(message: String) -> UIAlertController {
		let alertController = UIAlertController(title: Strings.errorAlertTitle.localized,
												message: message,
												preferredStyle: .alert)
		
		alertController.addAction(UIAlertAction(title: Strings.okActionTitle.localized, style: .default))

		return alertController
	}
}
