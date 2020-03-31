//
//  ViewController4.swift
//  Spartan Union Drink App
//
//  Created by Matthew Botchek on 4/16/18.
//  Copyright © 2018 Spartan Union. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import Foundation
import MessageUI

// This is the final view controller and handles emailing and size/listing drinks to be ordered
internal class ViewController4 : UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
	
	
	// Variables set here
	var choices = [String] ()
	
	var fullDrink = String ()
	
	@IBOutlet weak var segmentControl: UISegmentedControl!
	
	var size = String ()
	
    @IBOutlet weak var extra: UITextView!
    
	@IBAction func sizeValue(_ sender: Any) {
		switch segmentControl.selectedSegmentIndex
		{
		case 0:
			size = "Small";
		case 1:
			size = "Medium";
		case 2:
			size = "Large";
		default:
			break;
		}
	}
	
   
    @IBOutlet weak var orderTable: UITableView!
    
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return choices.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
		cell.textLabel?.text = choices[indexPath.item]
		return cell
	}
	
	// Opens and initializes keyboard. For extra options. 
	override func viewDidLoad() {
		super.viewDidLoad()
		fullDrink = Order().returnFullDrink()
		choices.append(fullDrink)
		
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
		
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
			if self.view.frame.origin.y == 0{
				self.view.frame.origin.y -= 75
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
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		orderTable.reloadData()
	}
	
	
	// This will call the function sendEmail() which is initialized by a UIButton
	@IBAction func submitOrder(_ sender: UIButton) {
		sendEmail()
	}
	
	func showAlert() {
		let alert = UIAlertController(title: "Error", message: "Could not send Mail", preferredStyle: .alert)
		let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	// This composes, formats, and retrieves data (not in that order) for the email that
	// Will be sent to the Spartan Union.
	// Essentially (hopefully) only way this can truly fail is if the phone user does not
	// Have an email.
	func sendEmail() {
		if MFMailComposeViewController.canSendMail() {
			if size == ""
			{
				size = "Small"
			}
			let ex = extra.text!
			let nm = Order().returnName()
			let rm = Order().returnRoom()
			let mail = MFMailComposeViewController()
			mail.mailComposeDelegate = self
			mail.setToRecipients(["brookfieldeast.spartanunion@gmail.com"])
			mail.setSubject("Drink Order")
			mail.setMessageBody("Room: \(rm) \n Name: \(nm) \n Drink: \(fullDrink) \n Size: \(size) \n Extra: \(ex)", isHTML: false)
			present(mail, animated: true)
		} else {
			self.showAlert()
		}
	}
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?){
		controller.dismiss(animated: true, completion: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func keyboardDissapear()
	{
		extra.resignFirstResponder();
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		keyboardDissapear()
	}
}
