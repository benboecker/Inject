//
//  Container.swift
//  DI
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation

public class Container {
	private var resolvers: [Resolver] = []
	public static let `default` = Container()
}

public extension Container {
	func register(_ types: Component.Type...) {
		for type in types {
			if type is Singleton.Type {
				resolvers.append(type.getSingletonResolver())
			} else {
				resolvers.append(type.getResolver())
			}
		}
	}

	func unregisterAll() {
		resolvers.removeAll()
	}
}

extension Container {
	func resolve<T>() -> T {
		for resolver in resolvers {
			if let resolved: T = resolver.resolve() {

				(resolved as? Component)?.onResolved()

				return resolved
			}
		}

		fatalError("Could not find a component for '\(T.self)', registered components are: \(resolvers.map { $0 })")
	}

}


