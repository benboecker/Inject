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





protocol Settings {
	var name: String { get }
}

final class SettingsComponent: Settings {
	
	static let shared = SettingsComponent()
	
	required init() {}

	var name: String = "\(Int.random(in: 0...10000))"
}
class SecondController {
	@Inject var settings: Settings
}



struct A {
	@Inject var b: B
}

struct B {
	@Inject var c: C
}

struct C {
	let value = "Test"
}

struct NestedController {
	@Inject var a: A
}



struct SimpleComponent {
	var name = "Test"
}
struct SimpleController {
	@Inject var simpleComponent: SimpleComponent
}


