//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 24.08.21.
//

import Foundation


public struct Registration: Resolver {
	let resolve: () -> Any
	let identifier: ObjectIdentifier
	let description: String
	
	public init<C>(_ resolving: @escaping () -> C) {
		self.identifier = ObjectIdentifier(C.self)
		self.resolve = resolving
		self.description = "'\(C.self)' with \(identifier)"
		print("Registering \(description)")
	}
	
	public init<C>(_ resolving: @escaping @autoclosure () -> C) {
		self.identifier = ObjectIdentifier(C.self)
		self.resolve = resolving
		self.description = "'\(C.self)' with \(identifier)"
		print("Registering \(description)")
	}
}
