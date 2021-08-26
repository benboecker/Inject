//
//  Resolver.swift
//  DI
//
//  Created by Benni on 14.06.19.
//  Copyright © 2019 BenBoecker. All rights reserved.
//

import Foundation


protocol Resolver {
	var resolve: () -> Any { get }
	var identifier: ObjectIdentifier { get }
	
	init<C>(_ resolving: @escaping () -> C)
	
}


