//
//  Inject.swift
//  DI
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation


@propertyWrapper
public class Inject<T> {
	private let component: T

	public init() {
		component = Container.default.resolve()!
	}

	public var wrappedValue: T {
		component
	}
}
