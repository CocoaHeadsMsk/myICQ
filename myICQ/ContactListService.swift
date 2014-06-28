//
//  ContactListService.swift
//  myICQ
//
//  Created by Ruslan Ahapkin on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation

class ContactListService {
	
	func contactList() -> Contact[] {
		var contactList = Contact[]()
		for index in 0..10 {
			var contact = Contact()
			contact.name = "ContactName\(index)"
			contact.nickname = "ContactNickname\(index)"
		}
		return contactList
	}
	
	func addContact(contact: Contact) {
		// TODO: send to server
	}
	
	func addContacts(constacts: Contact[]) {
		// TODO: send to server
	}
	
	func renameContact(contact: Contact, newName: String) {
		// TODO: save in core data and send new name to server.
		contact.name = newName
	}
}