//
//  File.swift
//  
//
//  Created by Benni on 17.06.19.
//

import Foundation



class InstancePool {
	static let shared = InstancePool()


	var instances: [Component] = []

	func add<T: Component>(instance: T) {
		let hasInstance = instances.contains { instance in
			return instance is T
		}

		if !hasInstance {
			instances.append(instance)
		}
	}

	func getInstance<T: Component>(_ type: T.Type) -> T {
		for instance in instances where instance is T {
			return instance as! T
		}

		add(instance: T())
		return getInstance(T.self)
	}

}
