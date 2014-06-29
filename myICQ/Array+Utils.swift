//
//  Array+Utils.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 29.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import Foundation


func indexOfInstance<C : Collection where C.GeneratorType.Element : AnyObject>(collection:C,  object:AnyObject) -> Int? {
	for (index, objectInArray) in enumerate(collection) {
		if objectInArray === object {
			return index
		}
	}
	return nil
}
extension Array {
	func indexOfInstance<T : Equatable>(o:T) -> Int? {
		if self.count > 0 {
			for (idx, objectToCompare) in enumerate(self) {
				let to = objectToCompare as T
				if o == to {
					return idx
				}
			}
		}

		return nil
	}
//	func indexOfInstance<Element : AnyObject>(object: Element) -> Int? {
//		for (index, objectInArray) in enumerate(self) {
//			let e1:AnyObject = objectInArray as AnyObject
//			let e2:AnyObject = object as AnyObject
//			if e1 === e2 {
//				return index
//			}
//		}
//		return nil
//	}
}