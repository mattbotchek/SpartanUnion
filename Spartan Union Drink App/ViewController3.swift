//
//  ViewController3.swift
//  Spartan Union Drink App
//
//  Created by Matthew Botchek on 4/16/18.
//  Copyright © 2018 Spartan Union. All rights reserved.
//

import UIKit
import WebKit
import Foundation

internal class ViewController3 : UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	
	//VARIABLES
	@IBOutlet weak var drinkTable: UITableView!
	
	var tableArray = [String] ()
	
	var flavorArray = [String]()
	
	var drinkFlavor = String ()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		getJson()
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		drinkTable.reloadData()
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return flavorArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
		cell.textLabel?.text = flavorArray[indexPath.item]
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let indexPath = tableView.indexPathForSelectedRow
		
		let currentCell = tableView.cellForRow(at: indexPath!) as! UITableViewCell
		
		drinkFlavor = (currentCell.textLabel!.text!)
		
		Order().getSecondPart(second: drinkFlavor)
		
		self.performSegue(withIdentifier: "to4", sender: self)
	}
	
	func getJson(){
		
		if let jsonObj = JSON().returnJSON() as? NSDictionary {
			
			if let header = jsonObj.value(forKey: "header") {
				
				if let firstArray = (header as AnyObject).value(forKey: "drinks") as? NSArray {
					
					for drinkable in firstArray {
						
						if let optionsArray = (drinkable as AnyObject).value(forKey: "drink") as? NSArray {
							
							for drink in optionsArray{
								
								if let drinkDict = drink as? NSDictionary {
									
									let vc2 = Order().returnFirstPart()
									
									if let test = drinkDict.value(forKey: vc2) as? NSArray {
										
										for flavor in test {
											
											if let flavors = (flavor as AnyObject).value(forKey: "flavor") {
												
												self.flavorArray.append((flavors as! String))
												
											}
										}
									}
								}
							}
						}
					}
				}
			}
			
			
			OperationQueue.main.addOperation({
				
			})
		}
	}
}





