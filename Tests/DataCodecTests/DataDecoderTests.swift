//
//  DataDecoderTests.swift
//  DataCodec
//
//  Created by Bernardo Breder on 07/01/17.
//
//

import XCTest
import Foundation
@testable import DataCodec

class DataDecoderTests: XCTestCase {
    
    func testInt() {
        XCTAssertEqual(UInt8.max, DataDecoder(bytes: DataEncoder().write(uint8: UInt8.max).unsafeBytes!).readUInt8())
        XCTAssertEqual(UInt16.max, DataDecoder(bytes: DataEncoder().write(uint16: UInt16.max).unsafeBytes!).readUInt16())
        XCTAssertEqual(UInt32.max, DataDecoder(bytes: DataEncoder().write(uint32: UInt32.max).unsafeBytes!).readUInt32())
        XCTAssertEqual(UInt64.max, DataDecoder(bytes: DataEncoder().write(uint64: UInt64.max).unsafeBytes!).readUInt64())
        
        XCTAssertEqual(Int16.min, DataDecoder(bytes: DataEncoder().write(int16: Int16.min).unsafeBytes!).readInt16())
        XCTAssertEqual(-64, DataDecoder(bytes: DataEncoder().write(int16: -64).unsafeBytes!).readInt16())
        XCTAssertEqual(-1, DataDecoder(bytes: DataEncoder().write(int16: -1).unsafeBytes!).readInt16())
        XCTAssertEqual(0, DataDecoder(bytes: DataEncoder().write(int16: 0).unsafeBytes!).readInt16())
        XCTAssertEqual(1, DataDecoder(bytes: DataEncoder().write(int16: 1).unsafeBytes!).readInt16())
        XCTAssertEqual(64, DataDecoder(bytes: DataEncoder().write(int16: 64).unsafeBytes!).readInt16())
        XCTAssertEqual(Int16.max, DataDecoder(bytes: DataEncoder().write(int16: Int16.max).unsafeBytes!).readInt16())
        
        XCTAssertEqual(Int32.min, DataDecoder(bytes: DataEncoder().write(int32: Int32.min).unsafeBytes!).readInt32())
        XCTAssertEqual(-128, DataDecoder(bytes: DataEncoder().write(int32: -128).unsafeBytes!).readInt32())
        XCTAssertEqual(-1, DataDecoder(bytes: DataEncoder().write(int32: -1).unsafeBytes!).readInt32())
        XCTAssertEqual(0, DataDecoder(bytes: DataEncoder().write(int32: 0).unsafeBytes!).readInt32())
        XCTAssertEqual(1, DataDecoder(bytes: DataEncoder().write(int32: 1).unsafeBytes!).readInt32())
        XCTAssertEqual(128, DataDecoder(bytes: DataEncoder().write(int32: 128).unsafeBytes!).readInt32())
        XCTAssertEqual(Int32.max, DataDecoder(bytes: DataEncoder().write(int32: Int32.max).unsafeBytes!).readInt32())
        
        XCTAssertEqual(Int64.min, DataDecoder(bytes: DataEncoder().write(int64: Int64.min).unsafeBytes!).readInt64())
        XCTAssertEqual(-128, DataDecoder(bytes: DataEncoder().write(int64: -128).unsafeBytes!).readInt64())
        XCTAssertEqual(-1, DataDecoder(bytes: DataEncoder().write(int64: -1).unsafeBytes!).readInt64())
        XCTAssertEqual(0, DataDecoder(bytes: DataEncoder().write(int64: 0).unsafeBytes!).readInt64())
        XCTAssertEqual(1, DataDecoder(bytes: DataEncoder().write(int64: 1).unsafeBytes!).readInt64())
        XCTAssertEqual(128, DataDecoder(bytes: DataEncoder().write(int64: 128).unsafeBytes!).readInt64())
        XCTAssertEqual(Int64.max, DataDecoder(bytes: DataEncoder().write(int64: Int64.max).unsafeBytes!).readInt64())
    }
    
    func testString() {
        XCTAssertEqual("123", DataDecoder(bytes: DataEncoder().write(string16: "123").unsafeBytes!).readString16())
        XCTAssertEqual("ação", DataDecoder(bytes: DataEncoder().write(string16: "ação").unsafeBytes!).readString16())
        XCTAssertEqual("123", DataDecoder(bytes: DataEncoder().write(string32: "123").unsafeBytes!).readString32())
        XCTAssertEqual("ação", DataDecoder(bytes: DataEncoder().write(string32: "ação").unsafeBytes!).readString32())
    }
    
    func testBool() {
        XCTAssertTrue(DataDecoder(bytes: DataEncoder().write(bool: true).unsafeBytes!).readBool()!)
        XCTAssertFalse(DataDecoder(bytes: DataEncoder().write(bool: false).unsafeBytes!).readBool()!)
    }
    
    func testDouble() {
        XCTAssertEqual(123, DataDecoder(bytes: DataEncoder().write(double: 123).unsafeBytes!).readDouble())
        XCTAssertEqual(123.23456789, DataDecoder(bytes: DataEncoder().write(double: 123.23456789).unsafeBytes!).readDouble())
        XCTAssertEqual(M_PI, DataDecoder(bytes: DataEncoder().write(double: M_PI).unsafeBytes!).readDouble())
    }
    
    func testBytes() {
        XCTAssertEqual([0x00, 0xFF], DataDecoder(bytes: DataEncoder().write(bytes16: [0x00, 0xFF]).unsafeBytes!).readBytes16()!)
    }
    
}
