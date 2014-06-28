//
//  ContactListViewController.swift
//  myICQ
//
//  Created by Petr Korolev on 28/06/14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation

class ContactListViewController : UITableViewController {
    
    let kCellIdentifier = "CellIdentifier"
    
    var contacts: NSArray = []
    
    var contactManager = ContactListManager()
    
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
}