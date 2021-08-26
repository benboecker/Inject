//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 24.08.21.
//

import Foundation


@propertyWrapper
public class LazyMutableInject<T> {
	private lazy var component: T = {
		Container.default.resolve()!
	}()

	public init() {}

	public var wrappedValue: T {
		get {
			component
		}
		set { component = newValue }
	}
}
