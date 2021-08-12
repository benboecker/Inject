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
	
	/// This function is used internally to get a resolver from a component. A default implementation is provided and this function does not have to be implemented by the concrete type.
	static func getResolver() -> Resolver
}

/**
Indicates whether a component gets resolved as a singleton.

When a component conforms to the Singleton protocol, only one instance of this component gets created and is always reused.
Must be a final class.
*/
public protocol Singleton: Component, AnyObject {
	static var shared: Self { get }
}

public extension Component {
	static func getResolver() -> Resolver {
		return InstanceResolver<Self>()
	}
}

public extension Singleton {
	static func getResolver() -> Resolver {
		return SingletonResolver<Self>()
	}

}

public extension Component {
	/**
	Default implementation of the `onResolved()` method. Does nothing, but may be overriden by custom components.
	*/
	func onResolved() { }
}

