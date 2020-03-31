//
//  ViewController2.swift
//  Spartan Union Drink App
//
//  Created by Matthew Botchek on 4/9/18.
//  Copyright © 2018 Spartan Union. All rights reserved.
//
import UIKit
import WebKit
import Foundation

// This ViewController is for the second in line ViewController and is the
// first scrolling/dynamically created drink list.
internal class ViewController2 : UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	
	// Initializing variables and grabs from the drink table
	var drink = String ()
	
	@IBOutlet weak var drinkTable: UITableView!
	
	var firstDrink = String ()
	
	var tableArray = [String] ()
	
	var drinkArray = [String] ()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getJson()
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		//drinkTable.reloadData()
	}
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return drinkArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
		cell.textLabel?.text = drinkArray[indexPath.item]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let indexPath = tableView.indexPathForSelectedRow
		
		let currentCell = tableView.cellForRow(at: indexPath!) as! UITableViewCell
		
		drink = (currentCell.textLabel!.text!)
		if drink == "Other Drink" {
			self.performSegue(withIdentifier: "toCustom", sender: self)
		}
		else {
			Order().getFirstPart(first: drink)
				
			self.performSegue(withIdentifier: "to3", sender: self)
		}
		
	}
	
	func showAlert() {
		let alert = UIAlertController(title: "Error", message: "Could not retrieve data from server", preferredStyle: .alert)
		let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	
	// Fetches the stored json from JSON.swift and finds what it needs to list drinks
	// In this case it is looking for the key header and listing each subsequent key that is
	// Drink
	func getJson(){
		
		if let jsonObj = JSON().returnJSON() as? NSDictionary {
			
			if let header = jsonObj.value(forKey: "header") {
				
				if let firstArray = (header as AnyObject).value(forKey: "drinks") as? NSArray {
					
					for drinkable in firstArray {
						
						if let optionsArray = (drinkable as AnyObject).value(forKey: "drink") as? NSArray {
							
							for drink in optionsArray{
								
								if let drinkDict = drink as? NSDictionary {
									
									if let test = drinkDict.value(forKey: "name") {
										
										self.drinkArray.append((test as! String))
										
									}
								}
							}
						}
					}
				}
			}
			
			OperationQueue.main.addOperation({
				//calling another function after fetching the json
			})
		}
	}
}



