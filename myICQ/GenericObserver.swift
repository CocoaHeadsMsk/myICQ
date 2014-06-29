//
//  GenericObserver.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 29.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation

class GenericObserver<T:AnyObject> {

	var _observers:T[] = []
	func addObserver(t:T) {
		_observers.append(t);
	}

	func removeObserver(t:T) {
		if let i = indexOfInstance(_observers, t) {
			_observers.removeAtIndex(i)
		}
	}

	func execute<F>(function:F) {
//		_observers.map(function)
/*		for o:T in _observers {

		}*/
	}
}