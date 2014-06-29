//
//  MessageManager.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation

class MessageManager {
	typealias MessageObserverCallback = ( Message[] )->Void

	class func sharedInstance() -> MessageManager {
		struct Static {
			static var instance: MessageManager? = nil
			static var onceToken: dispatch_once_t = 0
		}

		dispatch_once(&Static.onceToken) {
			Static.instance = self()
		}

		return Static.instance!
	}

	func _pushMessages(msg: Message[]) {
		for observer:MessageObserverCallback in _observers {
			observer(msg);
		}
	}

	var _messageCounter: Int = 0

	func generateTestMessages()->Message[] {
		var result: Message[] = []
		MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait( { context in
			
			for i:Int in 1..5 {
				var msg: Message = Message.MR_createInContext(context) as Message
				msg.text = "test message \(self._messageCounter)"
//				msg.sortOrder = self._messageCounter
				
				result += msg
				++self._messageCounter
			}
			}
		)
		return result
	}

    func generateMessageWithText(text : String) -> Message {
        var msg :Message? = nil
        MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait({ context in
            msg = Message.MR_createEntity() as? Message
            msg!.text = text
            })
        return msg!
    }
    
	func _runTestMessagesTimer() {
		var delay = Int64(NSEC_PER_SEC) * 5
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay),
			dispatch_get_main_queue()) {

				var testMessages: Message[] = self.generateTestMessages()
				self._pushMessages(testMessages)

				self._runTestMessagesTimer()
			}
	}

	@required init() {
		MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait() { context in
			self._messageCounter = Message.MR_countOfEntitiesWithContext(context)
			}

		self._runTestMessagesTimer()
	}

	@lazy var _observers : MessageObserverCallback[] = []

	func addIncomingMessageObserver( observer:MessageObserverCallback ) {
		_observers.append(observer)
	}
}