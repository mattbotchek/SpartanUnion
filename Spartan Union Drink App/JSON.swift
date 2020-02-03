//
//  JSON.swift
//  Spartan Union Drink App
//
//  Created by Matthew Botchek on 5/7/18.
//  Copyright © 2018 Matthew Botchek. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class JSON {
	
	let URL_UNION = "https://pastebin.com/raw/ZByHtyva"
	
	static var json = NSDictionary ()
	
	func getJSON(js: NSDictionary) {
		JSON.json = js
	}
	
	func returnJSON() -> NSDictionary {
		return JSON.json
	}
	
	func parseJSON(){
		//creating a NSURL
		let url = NSURL(string: URL_UNION)
		
		//fetching the data from the url
		URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
			if error != nil
			{
				print(error!)
				if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
					do {
						let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
						do{
							
							let jsonObj =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
							self.getJSON(js: jsonObj!)
						}catch let error{
							
							print(error.localizedDescription)
						}
						
					} catch let error {
						print(error.localizedDescription)
					}
				}
			}
			else {
				
				if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
					self.getJSON(js: jsonObj!)

				}
				OperationQueue.main.addOperation({
					//calling another function after fetching the json
				})
			}
		}).resume()
	}
}
