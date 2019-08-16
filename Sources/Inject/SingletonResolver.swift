//
//  File.swift
//  
//
//  Created by Benni on 17.06.19.
//

import Foundation



class SingletonResolver<InstanceType: Component>: Resolver {
	public func resolve<T>() -> T? {
		return InstancePool.shared.getInstance(InstanceType.self) as? T
	}
}
