//
//  UserDefaultsCache.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import Foundation

public class UserDefaultsCache: Caching {
    
    private static var _instance: Caching?
    private static let lock = NSLock()
    
    private var defaults: UserDefaults = UserDefaults.standard
    private var identifier: String = "UserDefaultsCache"
    
    private init(){}
    
    public static var instance: Caching {
        if _instance == nil {
            lock.lock()
            defer {
                lock.unlock()
            }
            if _instance == nil {
                _instance = UserDefaultsCache()
            }
        }
        return _instance!
    }
    
    public func save(data: Data, key: Cache.Key) {
        defaults.set(data, forKey: generate(key))
    }
    
    public func save(string: String, key: Cache.Key) {
        defaults.set(string, forKey: generate(key))
    }
    
    public func save(bool: Bool, key: Cache.Key) {
        defaults.set(bool, forKey: generate(key))
    }
    
    public func save(integer: Int, key: Cache.Key) {
        defaults.set(integer, forKey: generate(key))
    }
    
    public func save(array: [Any], key: Cache.Key) {
        defaults.set(array, forKey: generate(key))
    }
    
    public func save(dictionary: [String : Any], key: Cache.Key) {
        defaults.set(dictionary, forKey: generate(key))
    }
    
    public func save(double: Double, key: Cache.Key) {
        defaults.set(double, forKey: generate(key))
    }
    
    public func save(float: Float, key: Cache.Key) {
        defaults.set(float, forKey: generate(key))
    }
    
    public func readData(key: Cache.Key) -> Data? {
        return defaults.data(forKey: generate(key))
    }
    
    public func readString(key: Cache.Key) -> String? {
        return defaults.string(forKey: generate(key))
    }
    
    public func save<T: Codable>(value: T, key: Cache.Key) throws {
        return defaults.set(value, forKey: generate(key))
    }
    
    public func read<T:Codable>(type: T.Type, key: Cache.Key) throws -> T? {
        return defaults.value(forKey: generate(key)) as? T
    }
    
    public func readBool(key: Cache.Key) -> Bool? {
        return defaults.bool(forKey: generate(key))
    }
    
    public func readInteger(key: Cache.Key) -> Int? {
        return defaults.integer(forKey: generate(key))
    }
    
    public func readArray(key: Cache.Key) -> [Any]? {
        return defaults.array(forKey: generate(key))
    }
    
    public func readDictionary(key: Cache.Key) -> [String : Any]? {
        return defaults.dictionary(forKey: generate(key))
    }
    
    public func readDouble(key: Cache.Key) -> Double? {
        return defaults.double(forKey: generate(key))
    }
    
    public func readFloat(key: Cache.Key) -> Float? {
        return defaults.float(forKey: generate(key))
    }
    
    public func remove(key: Cache.Key) {
        defaults.removeObject(forKey: generate(key))
    }
    
    public func clear() {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            if key.contains(identifier) {
                defaults.removeObject(forKey: key)
            }
        }
    }
}

private extension UserDefaultsCache {
    private func generate(_ key: Cache.Key) -> String {
        return "\(identifier)-\(key.rawValue)"
    }
}

