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
	
	let name: String
	let imageURLString: String?
	let type: CardType?
	let playerClass: PlayerClass? // Some cards don't seem to have a player class?
}


enum CardType: String, Codable {
	case enchantment = "Enchantment"
	case hero = "Hero"
	case minion = "Minion"
	case power = "Hero Power"
	case spell = "Spell"
	case weapon = "Weapon"
}


enum PlayerClass: String, Codable {
	case deathKnight = "Death Knight"
	case dream = "Dream"
	case druid = "Druid"
	case hunter = "Hunter"
	case mage = "Mage"
	case neutral = "Neutral"
	case paladin = "Paladin"
	case priest = "Priest"
	case rogue = "Rogue"
	case shaman = "Shaman"
	case warlock = "Warlock"
	case warrior = "Warrior"
	case whizbang = "Whizbang"
}
