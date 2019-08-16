//
//  Component.swift
//  DI
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation


public protocol Component {
	init()

	static func getResolver() -> Resolver
	func onResolved()
}

public protocol Singleton {}


public extension Component {
	static func getResolver() -> Resolver {
		return InstanceResolver<Self>()
	}

	func onResolved() {
		
	}
}

public extension Component where Self: Singleton {
	static func getResolver() -> Resolver {
		return SingletonResolver<Self>()
	}
}
