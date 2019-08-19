//
//  File.swift
//  
//
//  Created by Benni on 17.06.19.
//

import Foundation

class InstanceResolver<InstanceType: Component>: Resolver {
	func resolve<T>() -> T? {
		return InstanceType.init() as? T
	}
}
