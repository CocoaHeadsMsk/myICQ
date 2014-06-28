//
//  ConversationController.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation

class ConversationController {

	@lazy var _loadedMessages :Array<Message> = self.loadMessages()

	func loadMessages() -> Array<Message> {
		return []
	}
	
	init() {
		_loadedMessages = []
	}

	func messageAtIndex(index: Int) -> Message {
		var msg: Message = Message();
		return msg;
	}

	func loadMore() {

	}

	func loadedCount() -> Int {
		return _loadedMessages.count;
	}
	
}