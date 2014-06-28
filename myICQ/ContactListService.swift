//
//  ContactListService.swift
//  myICQ
//
//  Created by Ruslan Ahapkin on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation

class ContactListService {
	
	@required init() {
		
	}
	
	class func sharedInstance() -> ContactListService {
		struct Static {
			static var instance: ContactListService? = nil
			static var onceToken: dispatch_once_t = 0
		}
		
		dispatch_once(&Static.onceToken) {
			Static.instance = self()
		}
		
		return Static.instance!
	}
	
	func addContact(contact: Contact) {
		// TODO: send to server
	}
	
	func addContacts(contacts: Contact[]) {
		// TODO: send to server
	}
	
	func removeContact(contact: Contact) {
		// TODO: send to server
	}
	
	func renameContact(contact: Contact, newName: String) {
		// TODO: send new name to server.
	}
}