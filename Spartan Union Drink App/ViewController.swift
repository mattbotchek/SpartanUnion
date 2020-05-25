//
//  ViewController.swift
//  Spartan Union Drink App
//
//  Created by Matthew Botchek on 2/28/18.
//  Copyright © 2018 Spartan Union. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit
import WebKit

class ViewController: UIViewController {
	
	//Spartan Union Twitter Page
	//@Sparty_Union
	
	
	//var drinkArray = [String]()
	
	// Gets the value for the text field NAME in the Room/Name controller (1st in line)
	@IBOutlet weak var textFieldName: UITextField!
	var name: String!
	
	
	// Gets the value for the text field ROOM in the Room/Name controller (1st in line)
	@IBOutlet weak var textFieldRoom: UITextField!
	var room: String!
	
	
	// Runs when the view is first loaded and runs everything within function
	// Essentially a "Start Up" function for view controllers
	// Every view controller will have one.
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		JSON().parseJSON()
		showAlert()
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

	}

	// Loads the keyboard and aligns at certain values (ie, 0 to 50)
	@objc func keyboardWillShow(notification: NSNotification) {
		if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
			if self.view.frame.origin.y == 0{
				self.view.frame.origin.y -= 50
			}
		}
	}
	
	// Hides the keyboard when clicked off
	@objc func keyboardWillHide(notification: NSNotification) {
		if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
			if self.view.frame.origin.y != 0{
				self.view.frame.origin.y = 0
			}
		}
	}
	
	// Ensures internet is available, if not uses backup locally stored json file for drinks
	func isInternetAvailable() -> Bool
	{
		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
		zeroAddress.sin_family = sa_family_t(AF_INET)
		
		let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
			$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
				SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
			}
		}
		
		var flags = SCNetworkReachabilityFlags()
		if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
			return false
		}
		let isReachable = flags.contains(.reachable)
		let needsConnection = flags.contains(.connectionRequired)
		return (isReachable && !needsConnection)
	}
	
	// Standard alert that needs better name, self explanitory
	func showAlert() {
		if !isInternetAvailable() {
			let alert = UIAlertController(title: "Warning", message: "The Internet is not available", preferredStyle: .alert)
			let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
			alert.addAction(action)
			present(alert, animated: true, completion: nil)
		}
	}
	
	// Standard alert that needs better name, self explanitory
	// Server in this case is the URL named in JSON.swift
	func showAlert2() {
		if !isInternetAvailable() {
			let alert = UIAlertController(title: "Warning", message: "Connection to server failed", preferredStyle: .alert)
			let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
			alert.addAction(action)
			present(alert, animated: true, completion: nil)
		}
	}
	
	
	
	
	@IBAction func nextButton(_ sender: Any) {
		name = textFieldName.text
		room = textFieldRoom.text
		Order().getName(nm: name)
		Order().getRoom(rm: room)

		
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
	}
	
	func keyboardDissapear()
	{
		textFieldName.resignFirstResponder();
		textFieldRoom.resignFirstResponder();
	}
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		keyboardDissapear()
	}
}



