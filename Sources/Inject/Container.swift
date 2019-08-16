//
//  Container.swift
//  DI
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation

public class Container {
	public static let `default` = Container()

	private var resolvers: [Resolver] = []

	public func register(_ types: Component.Type...) {
		for type in types {
			resolvers.append(type.getResolver())
		}
	}

	public func resolve<T>() -> T {
		for resolver in resolvers {
			if let resolved: T = resolver.resolve() {
				return resolved
			}
		}

		fatalError("Could not find a component for '\(T.self)', registered components are: \(resolvers.map { $0 })")
	}
}


