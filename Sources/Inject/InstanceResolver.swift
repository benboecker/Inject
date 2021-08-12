//
//  File.swift
//  
//
//  Created by Benni on 17.06.19.
//

import Foundation

class InstanceResolver<U: Component>: Resolver {
	func resolve<T>() -> T? {
		return U.init() as? T
	}
}

