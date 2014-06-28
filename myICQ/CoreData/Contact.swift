//
//  Contact.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation
import CoreData

@objc (Contact)
class Contact: NSManagedObject, Equatable {

	@NSManaged var name: String
	@NSManaged var nickname: String
	
	@objc(MR_entityName)
	class func MR_entityName() -> NSString {
		return "Contact"
	}
}

func ==(lhs: Contact, rhs: Contact) -> Bool {
	return lhs === rhs
}