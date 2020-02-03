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
	
	
	@IBOutlet weak var textFieldName: UITextField!
	var name: String!
	
	
	
	@IBOutlet weak var textFieldRoom: UITextField!
	var room: String!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		JSON().parseJSON()
		showAlert()
		
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

	}

	@objc func keyboardWillShow(notification: NSNotification) {
		if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
			if self.view.frame.origin.y == 0{
				self.view.frame.origin.y -= 50
			}
		}
	}
	
	
	@objc func keyboardWillHide(notification: NSNotification) {
		if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
			if self.view.frame.origin.y != 0{
				self.view.frame.origin.y = 0
			}
		}
	}
	
	
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
	
	
	func showAlert() {
		if !isInternetAvailable() {
			let alert = UIAlertController(title: "Warning", message: "The Internet is not available", preferredStyle: .alert)
			let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
			alert.addAction(action)
			present(alert, animated: true, completion: nil)
		}
	}
	
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



