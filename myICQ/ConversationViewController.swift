//
//  ConversationViewController.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
                            
	override func viewDidLoad() {
		super.viewDidLoad()
		MessageManager.sharedInstance().addIncomingMessageObserver(){ messages in
			for msg:Message in messages {

			}
		}
		// Do any additional setup after loading the view, typically from a nib.
	}

	func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
		return 1
	}

	var _messages: Message[]  = [];

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
		//cell?.textLabel.text = "hello"//msg.text
		return cell
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

