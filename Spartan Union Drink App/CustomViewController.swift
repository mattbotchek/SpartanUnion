//
//  CustomViewController.swift
//  Spartan Union Drink App
//
//  Created by Matthew Botchek on 2/3/20.
//  Copyright © 2020 Matthew Botchek. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit
import WebKit

class CustomViewController: UIViewController {
	
	
	@IBOutlet weak var custom_drink_field: UITextField!
	var drink: String!
	
	@IBOutlet weak var custom_flavor_field: UITextField!
	var flavor: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
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
	
	
	@IBAction func drinkSender(_ sender: Any) {
		drink = custom_drink_field.text
		flavor = custom_flavor_field.text
		Order().getFirstPart(first: drink)
		Order().getSecondPart(second: flavor)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
	}
	
	func keyboardDissapear()
	{
		custom_drink_field.resignFirstResponder();
		custom_flavor_field.resignFirstResponder();
	}
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		keyboardDissapear()
	}
}



