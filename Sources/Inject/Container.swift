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
		
	private var resolvers: [ObjectIdentifier: Resolver] = [:]
	
	private func register(_ registration: Registration) {
		resolvers[registration.identifier] = registration
	}
	
	public func register<C>(_ initialiser: @escaping @autoclosure () -> C) {
		register(Registration(initialiser))
	}
		
	public func register(@RegistrationBuilder _ registrations: () -> [Registration]) {
		for registration in registrations() {
			register(registration)
		}
	}
	
	public func canResolve<C>(_ type: C.Type) -> Bool {
		resolvers[ObjectIdentifier(C.self)] != nil
	}
	
	public func resolve<C>() -> C? {
		if let resolver = resolvers[ObjectIdentifier(C.self)] {
			let resolved = resolver.resolve() as? C
			
			(resolved as? ResolvingHandler)?.onResolved()
			
			return resolved
		} else {
			let des = resolvers.values.reduce("") {
				"\($0)\n\t- \(($1 as! Registration).description)"
			}
			print("No registration found for type \(C.self). Registered types: \(des)")
			return nil
		}
	}
	
	public func unregisterAll() {
		resolvers = [:]
	}
}
