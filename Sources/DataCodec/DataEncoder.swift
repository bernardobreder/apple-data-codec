//
//  DataCodec.swift
//  DataCodec
//
//  Created by Bernardo Breder on 07/01/17.
//
//

import Foundation

public class DataEncoder {
    
    internal var array: [UInt8] = []
    
    internal var error: Bool = false
    
    public init() {
    }
    
    @discardableResult
    public func write(uint8: UInt8) -> Self {
        array.append(uint8)
        return self
    }
    
    @discardableResult
    public func write(uint16: UInt16) -> Self {
        array.append(UInt8((uint16 >> 8) & 0xFF))
        array.append(UInt8(uint16 & 0xFF))
        return self
    }
    
    @discardableResult
    public func write(uint32: UInt32) -> Self {
        array.append(UInt8((uint32 >> 24) & 0xFF))
        array.append(UInt8((uint32 >> 16) & 0xFF))
        array.append(UInt8((uint32 >> 8) & 0xFF))
        array.append(UInt8(uint32 & 0xFF))
        return self
    }
    
    @discardableResult
    public func write(uint64: UInt64) -> Self {
        array.append(UInt8((uint64 >> 56) & 0xFF))
        array.append(UInt8((uint64 >> 48) & 0xFF))
        array.append(UInt8((uint64 >> 40) & 0xFF))
        array.append(UInt8((uint64 >> 32) & 0xFF))
        array.append(UInt8((uint64 >> 24) & 0xFF))
        array.append(UInt8((uint64 >> 16) & 0xFF))
        array.append(UInt8((uint64 >> 8) & 0xFF))
        array.append(UInt8(uint64 & 0xFF))
        return self
    }
    
    @discardableResult
    public func write(int16 int: Int16) -> Self {
        let uint = int < 0 ? abs(Int16(int + Int16(1))) : abs(int)
        write(uint16: (UInt16(uint) & 0x7FFF) + (int < 0 ? UInt16(0x8000) : 0))
        return self
    }
    
    @discardableResult
    public func write(int32 int: Int32) -> Self {
        let uint = int < 0 ? abs(Int32(int + Int32(1))) : abs(int)
        write(uint32: (UInt32(uint) & 0x7FFFFFFF) + (int < 0 ? UInt32(0x80000000) : 0))
        return self
    }
    
    @discardableResult
    public func write(int64 int: Int64) -> Self {
        let uint = int < 0 ? abs(Int64(int + Int64(1))) : abs(int)
        write(uint64: (UInt64(uint) & 0x7FFFFFFFFFFFFFFF) + (int < 0 ? (UInt64(0x80000000) << 32) : 0))
        return self
    }
    
    @discardableResult
    public func write(bool: Bool) -> Self {
        write(uint8: bool ? 0xFF : 0x00)
        return self
    }
    
    @discardableResult
    public func write(has: Any?) -> Self {
        return write(bool: has != nil)
    }
    
    public func write<E>(ifLet: E?) -> E? {
        write(bool: ifLet != nil)
        return ifLet
    }
    
    @discardableResult
    public func write(string16: String) -> Self {
        guard canWrite(string16: string16) else { error = true; return self }
        write(int16: Int16(string16.utf8.count))
        string16.utf8.forEach({ array.append($0) })
        return self
    }
    
    @discardableResult
    public func write(string32: String) -> Self {
        guard canWrite(string32: string32) else { error = true; return self }
        write(int32: Int32(string32.utf8.count))
        string32.utf8.forEach({ array.append($0) })
        return self
    }
    
    @discardableResult
    public func write(bytes16: [UInt8]) -> Self {
        guard canWrite(bytes16Count: bytes16.count) else { error = true; return self }
        write(int16: Int16(bytes16.count))
        bytes16.forEach({ array.append($0) })
        return self
    }
    
    @discardableResult
    public func write(bytes32: [UInt8]) -> Self {
        guard canWrite(bytes32Count: bytes32.count) else { error = true; return self }
        write(int32: Int32(bytes32.count))
        bytes32.forEach({ array.append($0) })
        return self
    }
    
    @discardableResult
    public func write(double: Double) -> Self {
        write(uint64: double.bitPattern)
        return self
    }
    
    public func canWrite(int16: Int) -> Bool {
        return Int16(int16) <= Int16.max && Int16(int16) >= Int16.min
    }
    
    public func canWrite(int32: Int) -> Bool {
        return Int32(int32) <= Int32.max && Int32(int32) >= Int32.min
    }
    
    public func canWrite(string16: String) -> Bool {
        let len = string16.utf8.count
        return len <= Int(Int16.max)
    }
    
    public func canWrite(string32: String) -> Bool {
        let len = string32.utf8.count
        return len <= Int(Int32.max)
    }
    
    public func canWrite(bytes16Count: Int) -> Bool {
        return bytes16Count <= Int(Int16.max)
    }
    
    public func canWrite(bytes32Count: Int) -> Bool {
        return bytes32Count <= Int(Int32.max)
    }
    
    public func data() -> Data? {
        guard !error else { return nil }
        return Data.init(bytes: array)
    }
    
    public func bytes() -> [UInt8]? {
        guard !error else { return nil }
        return [UInt8](array)
    }
    
    public var unsafeBytes: [UInt8]? {
        guard !error else { return nil }
        return array
    }

}

extension DataEncoder: CustomStringConvertible {
    
    public var description: String {
        return "[UInt8](\(array.count))"
    }

}
