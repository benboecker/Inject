//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 26.10.19.
//

import Foundation
import Inject


protocol IntegerCalculation {
	func compute(_ numbers: [Int]) -> Int
}

struct Addition: IntegerCalculation {
	func compute(_ numbers: [Int]) -> Int {
		numbers.reduce(0, +)
	}
}

struct Subtraction: IntegerCalculation {
	func compute(_ numbers: [Int]) -> Int {
		guard !numbers.isEmpty,
			  let n = numbers.first
			  
		else { return 0 }
		
		let remainingNumbers = numbers.dropFirst()
		let subractor = remainingNumbers.reduce(0, +)
				
		return n - subractor
	}
}

struct Multiplication: IntegerCalculation {
	func compute(_ numbers: [Int]) -> Int {
		guard !numbers.isEmpty else { return 1 }
		return numbers[0] * compute(Array(numbers[1...]))
	}
}

struct Fixed: IntegerCalculation {
	func compute(_ numbers: [Int]) -> Int {
		10
	}
}
