//
//  ConversationViewController.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import UIKit

let animationDuration = 1.0

class ConversationViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate, UIScrollViewDelegate {

	@IBOutlet var _tableView: UITableView
	@IBOutlet var textField: UITextField
	@IBOutlet var scrollButton: UIButton

	@IBAction func sendMessage(sender: UIButton) {
		_conversationController.sendMessage(textField.text)
		textField.text = ""

	}

	@lazy var _conversationController:ConversationController = ConversationController()

	var traking: Bool = true
	var _messages: Message[]  = []

	override func viewDidLoad() {
		super.viewDidLoad()
		_messages = _conversationController.loadMessages()

		_tableView.allowsSelection = false

		_conversationController.addIncomingMessageObserver(){ messages in

			var indexPaths = NSIndexPath[]()
			self._tableView.beginUpdates()
			for msg:Message in messages {
				indexPaths.append(NSIndexPath(forRow: self._messages.count, inSection: 0))
				self._messages.append(msg)
			}
			self._tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Bottom)
			self._tableView.endUpdates();

			if (self.traking){
				self._tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self._messages.count - 1, inSection: 0) , atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
			}


		}

		self.tabBarItem.badgeValue = String(_messages.count)

		scrollButton.addTarget(self, action: "scrollToBottomPressed", forControlEvents: .TouchUpInside)
		scrollButton.hidden = traking

	}

	func scrollToBottomPressed() -> Void {

		traking = true
		//        scrollButton.hidden = traking
		self._tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self._messages.count - 1, inSection: 0) , atScrollPosition: UITableViewScrollPosition.Middle, animated: true)

		UIView.animateWithDuration(animationDuration, animations: {
			self.scrollButton.alpha = 0
			}, completion: {
				(value: Bool) in
				self.scrollButton.hidden = true
			})

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

	func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
		tableView.deselectRowAtIndexPath(indexPath, animated: false)
	}

	func scrollViewWillBeginDragging(scrollView: UIScrollView!){
		traking = false
		scrollButton.hidden = traking
		UIView.animateWithDuration(animationDuration, animations: {
			self.scrollButton.alpha = 1
			}, completion: {
				(value: Bool) in
				self.scrollButton.hidden = false
			})

	}

}

