//
//  DataCodecTests.swift
//  DataCodec
//
//  Created by Bernardo Breder.
//
//

import XCTest
@testable import DataCodecTests

extension DataDecoderTests {

	static var allTests : [(String, (DataDecoderTests) -> () throws -> Void)] {
		return [
			("testBool", testBool),
			("testBytes", testBytes),
			("testDouble", testDouble),
			("testInt", testInt),
			("testString", testString),
		]
	}

}

extension DataEncoderTests {

	static var allTests : [(String, (DataEncoderTests) -> () throws -> Void)] {
		return [
			("test", test),
		]
	}

}

XCTMain([
	testCase(DataDecoderTests.allTests),
	testCase(DataEncoderTests.allTests),
])

