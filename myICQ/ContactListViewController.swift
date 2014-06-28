//
//  ContactListViewController.swift
//  myICQ
//
//  Created by Petr Korolev on 28/06/14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation

class ContactListViewController : UITableViewController {
    
    let kCellIdentifier = "ContactCell"
    
	var contacts: Contact[] {
	get {
		return ContactListManager.sharedInstance.contactList
	}
	}
	
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(style: UITableViewStyle)
    {
        super.init(style: style)
    }
    
    override func viewDidLoad() {

        self.navigationItem.title = "Contacts"
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addContact:")
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Generate", style: .Plain, target: self, action: "genarateContacts:")
    }
	
	override func viewWillAppear(animated: Bool) {
		updateBadge()
	}
	
	func genarateContacts(barButtonItem: UIBarButtonItem) {
		ContactListManager.sharedInstance.genarateContacts()
		updateUI()
	}
	
	func addContact(barButtonItem: UIBarButtonItem) {
		ContactListManager.sharedInstance.addContact() { contact in
			if contact {
				self.updateUI()
			}
		}
	}
	
	func updateBadge() {
		self.navigationController.tabBarItem.badgeValue = String(contacts.count)
	}
	
	func updateUI() {
		updateBadge()
		self.tableView.reloadData()
	}
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var obj : AnyObject! = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath)

        var cell = obj as UITableViewCell
        
        let contact = contacts[indexPath.row]
		
        cell.detailTextLabel.text = contact.name
        cell.textLabel.text = contact.nickname
		
        return cell
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
	
	override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
		return true
	}
	
	override func tableView(tableView: UITableView!, editingStyleForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCellEditingStyle {
		return .Delete
	}
	
	override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
		if editingStyle == .Delete {
			ContactListManager.sharedInstance.removeContact(contacts[indexPath.row])
			updateUI()
		}
	}
	
}