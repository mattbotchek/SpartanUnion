//
//  Order.swift
//  Spartan Union Drink App
//
//  Created by Matthew Botchek on 4/27/18.
//  Copyright © 2018 Matthew Botchek. All rights reserved.
//

// This sets the total drink value (ie, name, room, drink)
// Just a middle man for handling passing of data.
import Foundation
class Order {
	
	//Stuff for Name and Room
	
	static var name = String ()
	
	static var room = String ()
	
	func getName(nm: String)
	{
		Order.name = nm
	}
	
	func getRoom(rm: String)
	{
		Order.room = rm
	}
	
	func returnName() -> String
	{
		return Order.name
	}
	
	func returnRoom() -> String
	{
		return Order.room
	}
	
	//Stuff for drink
	static var firstPart = String ()
	
	static var secondPart = String()
	
	static var fullDrink = String()
	
	static var fullOrder = [String].self
	
	func getFirstPart(first: String)
	{
		Order.firstPart = first
	}
	
	func getSecondPart(second: String)
	{
		Order.secondPart = second
	}
	
	func createFullDrink()
	{
		Order.fullDrink = Order.firstPart + ": " + Order.secondPart
	}
	
	func returnFullDrink() -> String
	{
		createFullDrink()
		return Order.fullDrink
	}
	
	func returnFirstPart() -> String
	{
		return Order.firstPart
	}
	
}
