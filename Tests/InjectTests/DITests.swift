//
//  DITests.swift
//  DITests
//
//  Created by Benni on 08.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import XCTest
import Inject



class DITests: XCTestCase {

    func testDI() {
		Container.default.register(Addition() as IntegerCalculation)
		let controller = Controller()

		XCTAssertEqual(controller.compute(), 8)
	}

	func testSingleton() {
		Container.default.register(SettingsComponent.shared as Settings)

		let controller = SecondController()
		let randomName = controller.settings.name

		let anotherController = SecondController()
		let anotherRandomName = anotherController.settings.name

		XCTAssertEqual(randomName, anotherRandomName)
	}

	func testSimpleComponent() {
		Container.default.register(SimpleComponent())

		let simpleController = SimpleController()
		XCTAssertEqual(simpleController.simpleComponent.name, "Test")
	}
	
	func testCanResolve() {
		Container.default.register(Addition() as IntegerCalculation)
		
		XCTAssertTrue(Container.default.canResolve(IntegerCalculation.self))
		XCTAssertFalse(Container.default.canResolve(Addition.self))
	}

	func testNested() {
		let c = Container.default
		c.register(A())
		c.register(B())
		c.register(C())
		
		let nestedController = NestedController()
		
		XCTAssertEqual(nestedController.a.b.c.value, "Test")
	}
	
	func testRegisterResultBuilder() {
		Container.default.register {
			Registration(Addition() as IntegerCalculation)
			Registration(SettingsComponent.shared as Settings)
		}
		
		guard let add: IntegerCalculation = Container.default.resolve() else { return XCTFail() }
		guard let settings: Settings = Container.default.resolve() else { return XCTFail() }

		XCTAssertEqual(add.compute([5, 3]), 8)
		XCTAssertFalse(settings.name.isEmpty)
	}
	
	func testRegisterMultiple() {
		Container.default.register(Addition() as IntegerCalculation)
		Container.default.register(SettingsComponent.shared as Settings)
				
		guard let add: IntegerCalculation = Container.default.resolve() else { return XCTFail() }
		guard let settings: Settings = Container.default.resolve() else { return XCTFail() }
		
		XCTAssertEqual(add.compute([5, 3]), 8)
		XCTAssertFalse(settings.name.isEmpty)
	}
	
	
	
	override func tearDown() {
		super.tearDown()
		
		Container.default.unregisterAll()
	}
}
