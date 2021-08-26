//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 11.03.21.
//

import Foundation

@resultBuilder
public struct RegistrationBuilder {
	public static func buildBlock(_ registrations: Registration...) -> [Registration] {
		registrations
	}
}
