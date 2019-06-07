//
//  Card.swift
//  Innventory
//
//  Created by Xavier Chong on 2019-06-07.
//  Copyright © 2019 XJCHONG. All rights reserved.
//


struct Card: Codable {
	#warning("Create types for cardType and classType")
	let name: String
	let imageURLString: String
	let cardType: String
	let classType: String
}
