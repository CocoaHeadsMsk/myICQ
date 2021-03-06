//
//  ContactListManager.swift
//  myICQ
//
//  Created by Ruslan Ahapkin on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation
import CoreData

class ContactListManager {
	
	@lazy var contactList: Contact[] = Contact.MR_findAll() as Contact[]
	
	@required init() {
		
	}
	
	class var sharedInstance: ContactListManager {
		struct Static {
			static var instance: ContactListManager? = nil
			static var onceToken: dispatch_once_t = 0
		}
		
		dispatch_once(&Static.onceToken) {
			Static.instance = self()
		}
		
		return Static.instance!
	}
	
	func genarateContacts() {
		MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait() { context in
			let count = self.contactList.count
			for index in 1...10 {
				var contact = Contact.MR_createInContext(context) as Contact
				contact.name = "ContactName\(count + index)"
				contact.nickname = "ContactNickname\(count + index)"
				self.contactList += contact
			}
		}
	}
	
	func addContact(block: Contact? -> Void) {
		var contact: Contact? = nil
		
		MagicalRecord.saveUsingCurrentThreadContextWithBlock({ localContext in
			contact = self._createContactInContext(localContext)
			self.contactList += contact!
			ContactListService.sharedInstance().addContact(contact!)
			},
			completion: { success, error in block(contact) })
	}
	
	func removeContact(contact: Contact) {
		MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait() { context in
			if let index = self._indexOfContact(contact) {
				self.contactList.removeAtIndex(index)
				contact.MR_deleteInContext(context)
				ContactListService.sharedInstance().removeContact(contact)
			}
		}
	}
	
	func updateContact(contact: Contact) {
		MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait() { context in
			// TODO: save in core data and send new name to server.
			ContactListService.sharedInstance().updateContact(contact)
		}
	}
	
	func _createContactInContext(context: NSManagedObjectContext) -> Contact {
		let index = self.contactList.count + 1
		var contact = Contact.MR_createInContext(context) as Contact
		contact.name = "ContactName\(index)"
		contact.nickname = "ContactNickname\(index)"
		return contact
	}
	
	func _indexOfContact(contact: Contact) -> Int? {
		for (index, objectInArray) in enumerate(contactList) {
			if objectInArray === contact {
				return index
			}
		}
		return nil
	}
}