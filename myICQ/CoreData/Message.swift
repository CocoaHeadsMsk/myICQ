//
//  Message.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation
import CoreData

@objc (Message)
class Message : NSManagedObject {
	@NSManaged var text: String

	@objc(MR_entityName)
	class func MR_entityName()->NSString {
		return "Message"
	}
}