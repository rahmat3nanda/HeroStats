//
//  KeychainCache.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import Foundation

public class KeychainCache: Caching {
    
    private static var _instance: Caching?
    private static let lock = NSLock()
    
    private var identifier: String = "KeychainCache"
    
    private init(){}
    
    public static var instance: Caching {
        if _instance == nil {
            lock.lock()
            defer {
                lock.unlock()
            }
            if _instance == nil {
                _instance = KeychainCache()
            }
        }
        return _instance!
    }
    
    public func save(data: Data, key: Cache.Key) {
        KeychainService.save(key: generate(key), data: data)
    }
    
    public func save(string: String, key: Cache.Key) {
        if let data = string.data(using: .utf8) {
            KeychainService.save(key: generate(key), data: data)
        }
    }
    
    public func save(bool: Bool, key: Cache.Key) {
        KeychainService.save(key: generate(key), data: bool.data as Data)
    }
    
    public func save(integer: Int, key: Cache.Key) {
        KeychainService.save(key: generate(key), data: integer.data as Data)
    }
    
    public func save(array: [Any], key: Cache.Key) {
        KeychainService.save(key: generate(key), data: array.data)
    }
    
    public func save(dictionary: [String : Any], key: Cache.Key) {
        KeychainService.save(key: generate(key), data: dictionary.data)
    }
    
    public func save(double: Double, key: Cache.Key) {
        KeychainService.save(key: generate(key), data: double.data as Data)
    }
    
    public func save(float: Float, key: Cache.Key) {
        KeychainService.save(key: generate(key), data: float.data as Data)
    }
    
    public func save<T: Codable>(value: T, key: Cache.Key) throws {
        let data = try JSONEncoder().encode(value)
        KeychainService.save(key: generate(key), data: data)
    }
    
    public func read<T: Codable>(type: T.Type, key: Cache.Key) throws -> T? {
        guard let data = readData(key: key) else { return nil }
        return try JSONDecoder().decode(type, from: data)
    }
    
    public func readData(key: Cache.Key) -> Data? {
        return KeychainService.load(key: generate(key))
    }
    
    public func readString(key: Cache.Key) -> String? {
        let data = KeychainService.load(key: generate(key))
        if let data = data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    public func readBool(key: Cache.Key) -> Bool? {
        let data = KeychainService.load(key: generate(key))
        return Bool(data: data as? NSData ?? NSData())
    }
    
    public func readInteger(key: Cache.Key) -> Int? {
        let data = KeychainService.load(key: generate(key))
        return Int(data: data as? NSData ?? NSData())
    }
    
    public func readArray(key: Cache.Key) -> [Any]? {
        let data = KeychainService.load(key: generate(key))
        return Array(data: data ?? Data())
    }
    
    public func readDictionary(key: Cache.Key) -> [String : Any]? {
        let data = KeychainService.load(key: generate(key))
        return Dictionary(data: data ?? Data())
    }
    
    public func readDouble(key: Cache.Key) -> Double? {
        let data = KeychainService.load(key: generate(key))
        return Double(data: data as? NSData ?? NSData())
    }
    
    public func readFloat(key: Cache.Key) -> Float? {
        let data = KeychainService.load(key: generate(key))
        return Float(data: data as? NSData ?? NSData())
    }
    
    public func remove(key: Cache.Key) {
        KeychainService.remove(key: generate(key))
    }
    
    public func clear() {
        let keys = KeychainService.retrieveKeys()
        keys.forEach { key in
            if key.contains(identifier) {
                KeychainService.remove(key: key)
            }
        }
    }
}

private extension KeychainCache {
    private func generate(_ key: Cache.Key) -> String {
        return "\(identifier)-\(key.rawValue)"
    }
}

fileprivate extension Bool {
    var data: NSData {
        var _self = self
        return NSData(bytes: &_self, length: MemoryLayout.size(ofValue: self))
    }
    
    init?(data: NSData) {
        let size = MemoryLayout<Bool>.size
        guard data.length == size else { return nil }
        var value: Bool = false
        data.getBytes(&value, length: size)
        self = value
    }
}

fileprivate extension Int {
    var data: NSData {
        var _self = self
        return NSData(bytes: &_self, length: MemoryLayout.size(ofValue: self))
    }
    
    init?(data: NSData) {
        let size = MemoryLayout<Int>.size
        guard data.length == size else { return nil }
        var value: Int = 0
        data.getBytes(&value, length: size)
        self = value
    }
}

fileprivate extension Array<Any> {
    var data: Data {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            return data
        } catch {
            return Data()
        }
    }
    
    init?(data: Data) {
        do {
            if let array = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self], from: data) as? [Any] {
                self = array
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}

fileprivate extension Dictionary where Key == String, Value == Any {
    var data: Data {
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        return data ?? Data()
    }
    
    init?(data: Data) {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            self = jsonObject
        } else {
            return nil
        }
    }
}

fileprivate extension Double {
    var data: NSData {
        var _self = self
        return NSData(bytes: &_self, length: MemoryLayout.size(ofValue: self))
    }
    
    init?(data: NSData) {
        let size = MemoryLayout<Double>.size
        guard data.length == size else { return nil }
        var value: Double = 0.0
        data.getBytes(&value, length: size)
        self = value
    }
}

fileprivate extension Float {
    var data: NSData {
        var _self = self
        return NSData(bytes: &_self, length: MemoryLayout.size(ofValue: self))
    }
    
    init?(data: NSData) {
        let size = MemoryLayout<Float>.size
        guard data.length == size else { return nil }
        var value: Float = 0.0
        data.getBytes(&value, length: size)
        self = value
    }
}
