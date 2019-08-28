//
//  Container.swift
//  DI
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation

/**
The main *Dependency Injection* `Container` class. Is used to register Components that can then be used with the `@Inject` keyword.
Currently there is only one container supported, the one accessed via the static `default` property.
*/
public class Container {
	private var resolvers: [Resolver] = []

	/**
	Access to the singleton `Container` object.
	*/
	public static let `default` = Container()
}

public extension Container {
	/**
	This method is used to register `Component` types in the container. These can then be accessed with the `@Inject` keyword as instance properties.

	Example usage:

	```
	protocol Settings: Component {
	}
	struct SettingsComponent: Settings {
	    init() { }
	}

	Container.default.register(SettingsComponent.self)

	@Inject var comp: Settings
	```

	This way you can seperate the public api of your components from the actual implementation and swap them for mocks in unit tests.

	- Parameters:
	    - types: The types to register in the container. Must conform to the `Component` protocol.
	*/
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


