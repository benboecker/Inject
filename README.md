# Inject
> Dependency Injection using Swift 5.1 Property Wrappers  

This project is based on the [Wind Framework](https://github.com/palasthotel/wind), which provides a much more detailed and comprehensive solution for dependency injection. *Inject* is meant to be a lightweight alternative for smaller apps.

- - - -

## How does it work?
The concept of dependency injection takes a centralised approach with a container object that is responsible for initialising different components of an app that depend on other components (and providing these as well). By using protocols to declare dependencies and registering concrete types in the container, the components are decoupled from one another. This results in a more structured and testable architecture.

## How can I get it?
Using the Swift Package Manager, you can add the repository to your Xcode project as an external dependency. To integrate *Inject* into your Xcode project using Xcode 11, specify it in `Project > Swift Packages`:

`https://github.com/ivanvorobei/SPStorkController`

Alternatively, you can download the repository and include the files manually. This way, you will not get updates to the project.

## How do I use it?
Using the dependency injection system of the **Inject** Framework is a three step process.

- First you need a component. This is as easy as conforming to the `Component` protocol and providing an `init()` method to meet the requirements.
- Register the component's type at the global `Container` via the `register(_ types: Component.Type…)` function.
- Declare the variable for the component with the `@Inject` property wrapper.

### A very simple example

A simple component could look like this:

```swift
struct Settings: Component {
	var apiToken = "abc123"
}
```

To make use of a component, its type needs to be registered with the container. Currently the container exists only as a singleton of the  `Container` type, but this may change in the future to support multiple containers per application.

Registering the component looks like this:

```swift
Container.default.register(Settings.self)
```

To actually use the component, the `@Inject` property wrapper is used while declaring the variable.

```swift
struct API {
	@Inject var settings: Settings
}
```

The dependency injection system handles the initialization process of the `settings` variable so it is ready to use.


### A more complex example

Where the framework really shines is when using protocols and unit tests.

Consider the following example where an `API` component handles network calls to an existing service that authenticates via a token passed to it.

The API token is defined as a protocol.

```swift
protocol Token: Component {
	var value: String { get }
}
```

The protocol inherits from the `Component` protocol, so every type conforming to `Token` becomes a component automatically.

The `Token` protocol is used by the `API` struct by declaring a token with the `@Inject` keyword.

```swift
struct API {
	@Inject token: Token
}
```

The concrete implementation of the `Token` in the app looks like this.

```swift
struct ProductionToken: Token {
	var value: String
}
```

Also, the concrete type must be registered with the global container, otherwise the `@Inject` property wrapper will fail to resolve the component and the app will crash.

```swift
Container.default.register(ProductionToken.self)
```

In a unit test for the API struct, the token can be mocked with another implementation, that returns a test value.

```swift
struct TestToken: Token {
	var value: String {
		get { "TESTTOKEN" }
		set { }
	}
}
```

In the test case we register not the production token from the app, but the `TestToken` type. The property wrapper of the `API` now resolves to the `TestToken`, so this test will succeed.

```swift
class APITests: XCTestCase {
    func testToken() {
		Container.default.register(TestToken.self)
		let api = API()

		XCTAssertEqual(api.token.value, "TESTTOKEN")
	}
}
```


