//
//  ConversationViewController.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet var _tableView: UITableView
    @IBOutlet var textField: UITextField

	@lazy var _conversationController:ConversationController = ConversationController()

	var _messages: Message[]  = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		_messages = _conversationController.loadMessages()
		/*_conversationController.addIncomingMessageObserver(){ messages in

			var indexPaths = AnyObject[]()
			self._tableView.beginUpdates();
			for msg:Message in messages {
				indexPaths.append(NSIndexPath(forRow: self._messages.count, inSection: 0))
				self._messages.append(msg)
			}
			self._tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Bottom)
			self._tableView.endUpdates();

			
		}*/
		// Do any additional setup after loading the view, typically from a nib.
	}

	func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
		return 1
	}

	func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
		return _messages.count
	}

	func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		let cellIdentifier = "ConversationCell"
		var cell: UITableViewCell? = nil

		cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
		if let c = cell {

		} else {
			cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
		}

		var msg:Message = _messages[indexPath.row]
		cell!.textLabel.text = msg.text
		return cell
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func textFieldShouldReturn(textField: UITextField!) -> Bool{
		textField.resignFirstResponder()
		return true
		
		
	}
}

