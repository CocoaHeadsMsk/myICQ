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
    
    var contacts: Contact[] = []
    
    var contactManager = ContactListManager.sharedInstance()
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        fetchContacts()
    }
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        fetchContacts()
    }
    
    init(style: UITableViewStyle)
    {
        super.init(style: style)
        fetchContacts()
    }
    
    func fetchContacts() -> Void {
        contacts = contactManager.contactList
    }
    
    override func viewDidLoad() {

        self.navigationItem.title = "Contacts"
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var obj : AnyObject! = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath)

        var cell = obj as UITableViewCell
        
        let contact:Contact = contacts[indexPath.row] as Contact
        
        
        cell.detailTextLabel.text = contact.name
        cell.textLabel.text = contact.nickname
        
        return cell as UITableViewCell
        
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        var i = contacts.count
        return contacts.count
    }
}