//
//  CardCollectionViewController.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import ReactiveKit


class CardCollectionViewController: UIViewController {
	private let viewModel = CardCollectionViewModel()
	private let disposeBag = DisposeBag()
}

// MARK: - LifeCycle

extension CardCollectionViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		bindViewModel()
		
		viewModel.refreshCollection()
	}
	
	private func bindViewModel() {
		viewModel.errorMessages.observeNext { [weak self] errorMessage in
			guard let self = self else { return }
			
			self.present(UIAlertController.error(message: errorMessage), animated: true)
		}.dispose(in: disposeBag)
	}
}
