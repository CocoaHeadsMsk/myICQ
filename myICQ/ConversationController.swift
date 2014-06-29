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

	func loadMessages() -> Message[] {

		var result = Message[]()

		MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait( { context in
			result = Message.MR_findAllWithPredicate(nil, inContext: context) as Message[]
			for msg: Message in result {
				println(msg.text)
			}
			}
		)

		return result
	}
	
	init() {
		MessageManager.sharedInstance().addIncomingMessageObserver(){ messages in
			for callback:NewMessagesObserverCallback in self._observers {
				callback(messages)
			}
		}
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

	typealias NewMessagesObserverCallback = ( Message[] )->Void

	@lazy var _observers : NewMessagesObserverCallback[] = []

	func addIncomingMessageObserver( observer:NewMessagesObserverCallback ) {
		_observers.append(observer)
	}
	
    func sendMessage(message : String) -> Void{
        var msg = MessageManager.sharedInstance().generateMessageWithText(message)
        MessageManager.sharedInstance()._pushMessages([msg])
    }
}