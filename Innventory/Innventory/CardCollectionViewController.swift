//
//  CardCollectionViewController.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import ReactiveKit


class CardCollectionViewController: UIViewController {
	enum Strings: String, Localizable {
		case navigationTitle
		case searchBarButtonCancelTitle
		case searchBarPlaceholder
		case refreshErrorMessage
		
		var tableName: String { return "CardCollectionViewController" }
	}
	
	private enum Constants {
		static let cellWidthFactor: CGFloat = 2.2
		static let cellHeightFactor: CGFloat = 1.2
		
		static let searchButtonImageName = "outline_search_black_24pt"
		static let searchBarAnimationDuration = 0.2
	}
	
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
	
	@IBOutlet weak var emptyStateView: UIView!
	
	@IBOutlet weak var searchBarButton: UIBarButtonItem!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!

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
		viewModel.searchTerm.bidirectionalBind(to: searchBar.reactive.text)
		
		viewModel.isLoading.observeNext { [weak self] isLoading in
			guard let self = self, let refreshControl = self.collectionView.refreshControl else { return }
			
			isLoading ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
		}.dispose(in: disposeBag)

		viewModel.filteredCellViewModels.observeNext { [weak self] _ in
			self?.collectionView.reloadData()
		}.dispose(in: disposeBag)
		
		viewModel.filteredCellViewModels
			.map { !$0.collection.isEmpty }
			.bind(to: emptyStateView.reactive.isHidden)

		viewModel.isSearching
			.map { $0 ? nil : UIImage(named: Constants.searchButtonImageName) }
			.bind(to: searchBarButton.reactive.image)
		
		viewModel.isSearching
			.map { $0 ? Strings.searchBarButtonCancelTitle.localized : nil }
			.bind(to: searchBarButton.reactive.title)
		
		viewModel.isSearching.observeNext { [weak self] isSearching in
			guard let self = self else { return }
			
			let animations = {
				self.searchBarTopConstraint.constant = isSearching ? 0 : self.searchBar.bounds.height
				self.view.layoutIfNeeded()
			}
			
			let completion: (Bool) -> Void = { _ in
				if isSearching {
					self.searchBar.becomeFirstResponder()
				} else {
					self.view.endEditing(true)
				}
			}
			
			UIView.animate(withDuration: Constants.searchBarAnimationDuration,
						   delay: 0,
						   options: isSearching ? [.curveEaseOut] : [.curveEaseIn],
						   animations: animations,
						   completion: completion)
		}.dispose(in: disposeBag)

		viewModel.errors.observeNext { [weak self] error in
			switch error {
			case .refreshError:
    			self?.present(UIAlertController.error(message: Strings.refreshErrorMessage.localized), animated: true)
			}
		}.dispose(in: disposeBag)
	}
}


// MARK: - UICollectionViewDataSource

extension CardCollectionViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfItemsInSection(section)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: CardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
		let cellViewModel = viewModel.cellViewModel(for: indexPath)
		
		cell.bind(to: cellViewModel)

		return cell
	}
}


// MARK: - UICollectionViewDelegateFlowLayout

extension CardCollectionViewController: UICollectionViewDelegateFlowLayout {
	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		updateCollectionViewLayout(nextWidth: UIScreen.main.bounds.height)
	}
}


// MARK: - UISearchBarDelegate

extension CardCollectionViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		
		viewModel.performSearch()
	}
}


// MARK: - Actions

private extension CardCollectionViewController {
	@IBAction func toggleSearch(_ sender: AnyObject?) {
		viewModel.toggleSearch()
	}
}


// MARK: - Private

private extension CardCollectionViewController {
	func setupUI() {
		let refreshControl = UIRefreshControl()

		title = Strings.navigationTitle.localized
		
		updateCollectionViewLayout(nextWidth: UIScreen.main.bounds.width)
		refreshControl.addTarget(viewModel, action: #selector(viewModel.refreshCollection), for: .valueChanged)
		collectionView.refreshControl = refreshControl
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(CardCollectionViewCell.self)
		
		searchBarTopConstraint.constant = 0
		searchBar.placeholder = Strings.searchBarPlaceholder.localized
		searchBar.delegate = self

		view.layoutIfNeeded()
	}
	
	func updateCollectionViewLayout(nextWidth: CGFloat) {
		let cellWidth = nextWidth/Constants.cellWidthFactor
		let itemSpacing = floor((nextWidth - (cellWidth*2))/3)
		let sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
		
		collectionViewLayout.sectionInset = sectionInset
		collectionViewLayout.minimumInteritemSpacing = itemSpacing
		collectionViewLayout.itemSize = CGSize(width: nextWidth/Constants.cellWidthFactor,
											   height: nextWidth/Constants.cellHeightFactor)
		collectionViewLayout.invalidateLayout()
	}
}
