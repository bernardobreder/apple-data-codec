//
//  DataDecoder.swift
//  DataCodec
//
//  Created by Bernardo Breder on 07/01/17.
//
//

import Foundation

public class DataDecoder {
    
    let array: [UInt8]
    
    var index: Int = 0
    
    public init(data: Data) {
        array = [UInt8](data)
    }
    
    public init(bytes: [UInt8]) {
        array = bytes
    }
    
    public func readUInt8() -> UInt8? {
        guard index < array.count else { return nil }
        let result = array[index]
        index += 1
        return result
    }
    
    public func readUInt16() -> UInt16? {
        guard index + 1 < array.count else { return nil }
        var result = (UInt16(array[index]) << 8)
        result += UInt16(array[index + 1])
        index += 2
        return result
    }
    
    public func readUInt32() -> UInt32? {
        guard index + 3 < array.count else { return nil }
        var result = (UInt32(array[index]) << 24)
        result += (UInt32(array[index + 1]) << 16)
        result += (UInt32(array[index + 2]) << 8)
        result += UInt32(array[index + 3])
        index += 4
        return result
    }
    
    public func readUInt64() -> UInt64? {
        guard index + 7 < array.count else { return nil }
        var result = (UInt64(array[index]) << 56)
        result += (UInt64(array[index + 1]) << 48)
        result += (UInt64(array[index + 2]) << 40)
        result += (UInt64(array[index + 3]) << 32)
        result += (UInt64(array[index + 4]) << 24)
        result += (UInt64(array[index + 5]) << 16)
        result += (UInt64(array[index + 6]) << 8)
        result += UInt64(array[index + 7])
        index += 8
        return result
    }
    
    public func readInt16() -> Int16? {
        guard let value = readUInt16() else { return nil }
        var result = Int16(value & 0x7FFF)
        let neg = UInt16(0x8000)
        if (value & neg) == neg {
            result = -result - 1
        }
        return result
    }
    
    public func readInt32() -> Int32? {
        guard let value = readUInt32() else { return nil }
        var result = Int32(value & 0x7FFFFFFF)
        let neg = UInt32(0x80000000)
        if (value & neg) == neg {
            result = -result - 1
        }
        return result
    }
    
    public func readInt64() -> Int64? {
        guard let value = readUInt64() else { return nil }
        var result = Int64(value & 0x7FFFFFFFFFFFFFFF)
        let neg = UInt64(0x80000000) << 32
        if (value & neg) == neg {
            result = -result - 1
        }
        return result
    }
    
    public func readBool() -> Bool? {
        guard let value = readUInt8() else { return nil }
        guard value == 0 || value == 0xFF else { return nil }
        return value == 0xFF
    }
    
    public func readHasData() -> Bool? {
        return readBool()
    }
    
    public func readString16() -> String? {
        guard let len16 = readInt16() else { return nil }
        let len = Int(len16)
        var bytes = [UInt8].init(repeating: 0, count: len)
        for i in 0 ..< len {
            bytes[i] = array[index + i]
        }
        index += len
        return String(bytes: bytes, encoding: .utf8)
    }
    
    public func readString32() -> String? {
        guard let len32 = readInt32() else { return nil }
        let len = Int(len32)
        var bytes = [UInt8].init(repeating: 0, count: len)
        for i in 0 ..< len {
            bytes[i] = array[index + i]
        }
        index += len
        return String(bytes: bytes, encoding: .utf8)
    }
    
    public func readBytes16() -> [UInt8]? {
        guard let len16 = readInt16() else { return nil }
        let len = Int(len16)
        var bytes = [UInt8].init(repeating: 0, count: len)
        for i in 0 ..< len {
            bytes[i] = array[index + i]
        }
        index += len
        return bytes
    }
    
    public func readBytes32() -> [UInt8]? {
        guard let len32 = readInt32() else { return nil }
        let len = Int(len32)
        var bytes = [UInt8].init(repeating: 0, count: len)
        for i in 0 ..< len {
            bytes[i] = array[index + i]
        }
        index += len
        return bytes
    }
    
    public func readDouble() -> Double? {
        guard let value = readUInt64() else { return nil }
        return Double.init(bitPattern: value)
    }
    
    public func readArray16<T>(_ f: (DataDecoder) -> T?) -> [T]? {
        guard let count16 = readUInt16() else { return nil }
        let count = Int(count16)
        var array: [T] = []
        for _ in 1 ... count {
            if let item = f(self) { array.append(item) }
        }
        return array
    }
    
    public func readArray32<T>(_ f: (DataDecoder) -> T?) -> [T]? {
        guard let count32 = readUInt32() else { return nil }
        let count = Int(count32)
        var array: [T] = []
        for _ in 1 ... count {
            if let item = f(self) { array.append(item) }
        }
        return array
    }
    
    public var avaliable: Int {
        return array.count - index
    }

}

extension DataDecoder: CustomStringConvertible {
    
    public var description: String {
        return "[UInt8](\(index)-\(array.count))"
    }
    
}
