//
//  Card.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//


struct Card: Codable {
	
	enum CodingKeys: String, CodingKey {
		case name
		case imageURLString = "img"
		case type
		case playerClass
	}
	
	#warning("Create types for type and playerClass")
	let name: String
	let imageURLString: String?
	let type: String
	let playerClass: String? // Some cards don't seem to have a player class?
}
