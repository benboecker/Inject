//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 24.08.21.
//

import Foundation
import OSLog


public struct Registration: Resolver {
	let resolve: () -> Any
	let identifier: ObjectIdentifier
	let description: String
	private let logger = Logger(subsystem: "Inject", category: "Registration")
	
	public init<C>(_ resolving: @escaping () -> C) {
		self.identifier = ObjectIdentifier(C.self)
		self.resolve = resolving
		let descr = "'\(C.self)' with \(identifier)"
		self.description = descr
		logger.info("\(descr)")
	}
	
	public init<C>(_ resolving: @escaping @autoclosure () -> C) {
		self.identifier = ObjectIdentifier(C.self)
		self.resolve = resolving
		let descr = "'\(C.self)' with \(identifier)"
		self.description = descr
		logger.info("\(descr)")
	}
}
