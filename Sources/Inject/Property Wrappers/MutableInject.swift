//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 24.08.21.
//

import Foundation


@propertyWrapper
public class MutableInject<T> {
	private var component: T

	public init() {
		component = Container.default.resolve()!
	}

	public var wrappedValue: T {
		get {
			component
		}
		set { component = newValue }
	}
}
