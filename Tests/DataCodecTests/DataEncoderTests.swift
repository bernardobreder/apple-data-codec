//
//  DataEncoder.swift
//  DataCodec
//
//  Created by Bernardo Breder on 07/01/17.
//
//

import XCTest
@testable import DataCodec

class DataEncoderTests: XCTestCase {

	func test() throws {
        XCTAssertEqual([UInt8]([0xFF]), DataEncoder().write(uint8: UInt8.max).unsafeBytes!)
        XCTAssertEqual([UInt8]([0x00]), DataEncoder().write(uint8: UInt8.min).unsafeBytes!)
        XCTAssertEqual([UInt8]([0xFF, 0xFF]), DataEncoder().write(uint16: UInt16.max).unsafeBytes!)
        XCTAssertEqual([UInt8]([0x00, 0x80]), DataEncoder().write(uint16: 128).unsafeBytes!)
        XCTAssertEqual([UInt8]([0x00, 0x00]), DataEncoder().write(uint16: UInt16.min).unsafeBytes!)
        XCTAssertEqual([UInt8]([0xFF, 0xFF, 0xFF, 0xFF]), DataEncoder().write(uint32: UInt32.max).unsafeBytes!)
        XCTAssertEqual([UInt8]([0x00, 0x00, 0x00, 0x80]), DataEncoder().write(uint32: 128).unsafeBytes!)
        XCTAssertEqual([UInt8]([0x00, 0x00, 0x00, 0x00]), DataEncoder().write(uint32: UInt32.min).unsafeBytes!)
        XCTAssertEqual([UInt8]([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]), DataEncoder().write(uint64: UInt64.max).unsafeBytes!)
        XCTAssertEqual([UInt8]([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80]), DataEncoder().write(uint64: 128).unsafeBytes!)
        XCTAssertEqual([UInt8]([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]), DataEncoder().write(uint64: UInt64.min).unsafeBytes!)
	}

}

