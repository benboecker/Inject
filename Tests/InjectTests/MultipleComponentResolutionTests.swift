//
//  MultipleComponentResolutionTests.swift
//  
//
//  Created by Benjamin Böcker on 26.10.19.
//

import Foundation
import XCTest
import Inject




class MultipleComponentResolutionTests: XCTestCase {

	override func setUp() {
		super.setUp()
		
		Container.default.unregisterAll()

		Container.default.register(
			Addition.self,
			Subtraction.self,
			Multiplication.self,
			Fixed.self
		)
	}
	
	
	func testMultipleDependencyResolution() {
	
		let dependencies: [IntegerCalculation] = Container.default.resolveDependencies()
		XCTAssertEqual(dependencies.count, 4)
		
		guard let addition: Addition = Container.default.resolveDependency() else { XCTFail(); return }
		guard let subtraction: Subtraction = Container.default.resolveDependency() else { XCTFail(); return }
		guard let multiplication: Multiplication = Container.default.resolveDependency() else { XCTFail(); return }
		guard let fixed: Fixed = Container.default.resolveDependency() else { XCTFail(); return }
		
		XCTAssertEqual(addition.compute([10, 30, 50]), 90)
		XCTAssertEqual(subtraction.compute([100, 30, 50]), 20)
		XCTAssertEqual(multiplication.compute([3, 4, 6]), 72)
		XCTAssertEqual(fixed.compute([100, 30, 50]), 10)
		
	}
	
	override func tearDown() {
		super.tearDown()
		
		Container.default.unregisterAll()
	}
}
