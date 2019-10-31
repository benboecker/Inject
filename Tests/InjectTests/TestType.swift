//
//  TestType.swift
//  DITests
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation
import Inject



class Controller {
	@Inject var calculation: IntegerCalculation

	func compute() -> Int {
		return calculation.compute([5, 3])
	}
}





protocol Settings: Component, Singleton {
	var name: String { get }
}

class SettingsComponent: Settings {
	required init() {}

	var name: String = "\(Int.random(in: 0...10000))"
}
class SecondController {
	@Inject var settings: Settings
}



struct A: Component {
	@Inject var b: B
}

struct B: Component {
	@Inject var c: C
}

struct C: Component {
	let value = "Test"
}

struct NestedController {
	@Inject var a: A
}



struct SimpleComponent: Component {
	var name = "Test"
}
struct SimpleController {
	@Inject var simpleComponent: SimpleComponent
}


