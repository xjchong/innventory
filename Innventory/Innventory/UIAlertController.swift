//
//  UIAlertController.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import UIKit


extension UIAlertController {
	class func error(message: String) -> UIAlertController {
		#warning("Localize strings")
		let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		
		alertController.addAction(UIAlertAction(title: "OK", style: .default))

		return alertController
	}
}
