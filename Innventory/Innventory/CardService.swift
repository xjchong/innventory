//
//  CardService.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//

import Alamofire


class CardService {
	
	private enum Constant {
		static let getAllCardsURLString = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards"
		static let getAllCardsKey = "9fa74cfb32msh677a6fff8b8380fp1fa79cjsn904c6b967133"
		static let hostURLString = "omgvamp-hearthstone-v1.p.rapidapi.com"
		
		static let playableCardSets = ["Basic",
									   "Classic",
									   "Naxxramas",
									   "Goblins vs Gnomes",
									   "Blackrock Mountain",
									   "Tavern Brawl",
									   "The Grand Tournament"]
	}
	
	private enum AttributeName {
		static let host = "X-RapidAPI-Host"
		static let key = "X-RapidAPI-Key"
	}

	static func getAllCards(completion: @escaping (Swift.Result<[Card], Error>) -> ()) {
		Alamofire.request(Constant.getAllCardsURLString,
						  headers: [AttributeName.host : Constant.hostURLString,
									AttributeName.key : Constant.getAllCardsKey])
			.validate()
			.responseJSON { response in
				switch response.result {
				case .success(let json):
					let decoder = JSONDecoder()
	
					do {
						let cardsBySet = try decoder.decode([String: [Card]].self, from: response.data!)
						let cards = cardsBySet.flatMap { $0.value }

						completion(.success(cards))
					} catch let error {
						completion(.failure(error))
					}
				case .failure(let error):
					completion(.failure(error))
				}
		}
	}
}
