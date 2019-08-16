//
//  DITests.swift
//  DITests
//
//  Created by Benni on 08.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import XCTest
import Inject
import GitLab



class DITests: XCTestCase {

    func testDI() {

		Container.default.register(Addition.self)
		let controller = Controller()

		XCTAssertEqual(controller.compute(), 8)



	}


	func testSingleton() {
		Container.default.register(SettingsComponent.self)


		let controller = SecondController()
		let randomName = controller.settings.name

		let anotherController = SecondController()
		let anotherRandomName = anotherController.settings.name

		XCTAssertEqual(randomName, anotherRandomName)
	}

	func testSimpleComponent() {

		Container.default.register(SimpleComponent.self)

		let simpleController = SimpleController()
		XCTAssertEqual(simpleController.simpleComponent.name, "Test")

	}

	func testNested() {

		Container.default.register(A.self)
		Container.default.register(B.self)
		Container.default.register(C.self)

		let nestedController = NestedController()

		XCTAssertEqual(nestedController.a.b.c.value, "Test")
	}
}
