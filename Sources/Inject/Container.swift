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

	/**
	This method simply removes all registered resolvers. It's main purpose is to be used in unit tests where you need this specific behaviour to reset state.
	*/
	func unregisterAll() {
		resolvers.removeAll()
		InstancePool.shared.instances = []
	}
	
	/**
	This method provides direct resolution of registered dependencies, bypassing the `@Inject` property wrapper.
	
	Often you just register one Component for a given type, but the `Container` type allows you to register more than one component of the same type. With this method you can get all implementations of that type.
	
	- Returns: An array of the resolved dependencies of type `T`.
	*/
	func resolveDependencies<T>() -> [T] {
		var resolvedDependencies: [T] = []
		
		for resolver in resolvers {
			if let dependency: T = resolver.resolve() {
				(dependency as? Component)?.onResolved()
				resolvedDependencies.append(dependency)
			}
		}
		
		return resolvedDependencies
	}
	
	/**
	This method provides direct resolution of registered dependencies, bypassing the `@Inject` property wrapper.
	
	Often you just register one Component for a given type, but the `Container` type allows you to register more than one component of the same type. With this method you can get the first implementation of that type.
	
	- Returns: A initialised component of the resolved dependencies of type `T?`. returns `nil` if no such component is registered.
	*/
	func resolveDependencies<T>() -> T? {
		let resolvedDependencies: [T] = resolveDependencies()
		return resolvedDependencies.first
	}
		
}

extension Container {
	func resolve<T>() -> T {
		let dependencies: [T] = resolveDependencies()
		
		guard let dependency = dependencies.first else {
			fatalError("Could not find a component for '\(T.self)', registered components are: \(resolvers.map { $0 })")
		}
		
		return dependency
	}

}


