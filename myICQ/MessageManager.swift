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

	func _pushMessage(msg: Message) {
		for observer:MessageObserverCallback in _observers {
			observer([msg]);
		}
	}

	func runTestMessagesTimer() {
		var delay = Int64(NSEC_PER_SEC) * 10;
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay),
			dispatch_get_main_queue()) {

				self.runTestMessagesTimer()
			}
	}

	@required init() {

	}

	@lazy var _observers : MessageObserverCallback[] = []

	func addIncomingMessageObserver( observer:MessageObserverCallback ) {
		_observers.append(observer)
	}
}