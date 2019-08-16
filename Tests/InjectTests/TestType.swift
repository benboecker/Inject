//
//  TestType.swift
//  DITests
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation
import Inject

protocol Math {
	func computation(_ first: Int, _ second: Int) -> Int
}

class Addition: Math, Component {
	required init() { }

	func computation(_ first: Int, _ second: Int) -> Int {
		return first + second
	}
}

class Subtraction: Math, Component {
	func computation(_ first: Int, _ second: Int) -> Int {
		first - second
	}

	required init() {}
}


class Controller {
	@Inject var math: Math

	func compute() -> Int {
		return math.computation(5, 3)
	}
}





protocol Settings {
	var name: String { get }
}

class SettingsComponent: Component, Singleton, Settings {
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


