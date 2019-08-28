//
//  Component.swift
//  DI
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation


/**
Protocol to indicate a type as a component used by the dependency injection system.
*/
public protocol Component {
	/**
	Required init method so that a component can be instantiated when needed.
	*/
	init()

	/**
	Callback for additional setup after the components gets resolved.
	*/
	func onResolved()
}

/**
Indicates whether a component gets resolved as a singleton.

When a component additionally conforms to the Singleton protocol, only one instance of this component gets created and alsways reused.
*/
public protocol Singleton {}

extension Component {
	static func getSingletonResolver() -> Resolver {
		return SingletonResolver<Self>()
	}

	static func getResolver() -> Resolver {
		return InstanceResolver<Self>()
	}
}

public extension Component {
	func onResolved() {
		
	}
}

