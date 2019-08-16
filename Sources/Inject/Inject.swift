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
	private lazy var component: T = { Container.default.resolve() }()

	public init() {}

	public var wrappedValue: T {
		get { component }
		set { component = newValue }
	}
}
