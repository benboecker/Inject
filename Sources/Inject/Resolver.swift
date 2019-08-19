//
//  Resolver.swift
//  DI
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation


protocol Resolver {
	func resolve<T>() -> T?
}


