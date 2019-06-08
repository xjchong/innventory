//
//  CardCollectionViewController.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import ReactiveKit


class CardCollectionViewController: UIViewController {
	private enum Constants {
		static let cellWidthFactor: CGFloat = 2.2
		static let cellHeightFactor: CGFloat = 1.5
	}
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
	
	
	private let viewModel = CardCollectionViewModel()
	private let disposeBag = DisposeBag()
}

// MARK: - LifeCycle

extension CardCollectionViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		
		bindViewModel()
		viewModel.refreshCollection()
	}
	
	private func bindViewModel() {
		viewModel.cellViewModels.observeNext { [weak self] _ in
			self?.collectionView.reloadData()
		}.dispose(in: disposeBag)
		
		viewModel.errorMessages.observeNext { [weak self] errorMessage in
			self?.present(UIAlertController.error(message: errorMessage), animated: true)
		}.dispose(in: disposeBag)
	}
}


// MARK: - UICollectionViewDataSource

extension CardCollectionViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.cellViewModels.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: CardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
		let cellViewModel = viewModel.cellViewModels[indexPath.item]
		
		cell.bind(to: cellViewModel)
		cell.translatesAutoresizingMaskIntoConstraints = true
		
		return cell
	}
}


// MARK: - UICollectionViewDelegate

extension CardCollectionViewController: UICollectionViewDelegate {
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		let width = collectionView.contentSize.width/2
//		let height = width
//
//		return CGSize(width: width, height: height)
//	}
}


// MARK: - Private

private extension CardCollectionViewController {
	func setupUI() {
		let collectionViewWidth = collectionView.bounds.width
		
		title = viewModel.title
		
		collectionViewLayout.itemSize = CGSize(width: collectionViewWidth/Constants.cellWidthFactor,
											   height: collectionViewWidth/Constants.cellHeightFactor)
		
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(CardCollectionViewCell.self)
	}
}
