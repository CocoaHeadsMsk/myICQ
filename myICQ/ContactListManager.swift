//
//  ContactListManager.swift
//  myICQ
//
//  Created by Ruslan Ahapkin on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation

class ContactListManager {
	
	@lazy var contactList: Contact[] = {
		var contactList = Contact[]()
		MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait() { context in
			for index in 0..10 {
				var contact = Contact.MR_createInContext(context) as Contact
				contact.name = "ContactName\(index)"
				contact.nickname = "ContactNickname\(index)"
				contactList += contact
			}
		}
		return contactList
		}()
	
	@required init() {
		
	}
	
	class func sharedInstance() -> ContactListManager {
		struct Static {
			static var instance: ContactListManager? = nil
			static var onceToken: dispatch_once_t = 0
		}
		
		dispatch_once(&Static.onceToken) {
			Static.instance = self()
		}
		
		return Static.instance!
	}
	
	func addContact(contact: Contact) {
		// TODO: send to server
		contactList += contact
		
		ContactListService.sharedInstance().addContact(contact)
	}
	
	func addContacts(contacts: Contact[]) {
		contactList += contacts
		
		ContactListService.sharedInstance().addContacts(contacts)
	}
	
	func removeContact(contact: Contact) {
		if let index = _indexOfContact(contact) {
			contactList.removeAtIndex(index)
		}
		
		ContactListService.sharedInstance().addContact(contact)
	}
	
	func renameContact(contact: Contact, newName: String) {
		// TODO: save in core data and send new name to server.
		ContactListService.sharedInstance().renameContact(contact, newName: newName)
	}
	
	func _indexOfContact(contact: Contact) -> Int? {
		for (index, objectInArray) in enumerate(contactList) {
			if objectInArray == contact {
				return index
			}
		}
		return nil
	}
}