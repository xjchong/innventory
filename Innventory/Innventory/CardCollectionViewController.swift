//
//  CardCollectionViewController.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import UIKit


class CardCollectionViewController: UIViewController {
	
	// MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		CardService.getAllCards { result in
			switch result {
			case .success(let cards):
				print("CardCollectionViewController received success! (received \(cards.count) cards)")
			case .failure(let error):
				print("CardCollectionViewController received failure... (error: \(error.localizedDescription)")
			}
		}
	}
}

