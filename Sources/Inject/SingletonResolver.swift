//
//  File.swift
//  
//
//  Created by Benni on 17.06.19.
//

import Foundation



class SingletonResolver<U: Singleton>: Resolver {
	func resolve<T>() -> T? {
		U.shared as? T
	}
}
