//
//  Caching.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import Foundation


/**
 Is a protocol for Cache.
 */
public protocol Caching {
    
    
    /**
     Gets an instance of Caching
     - returns: Caching
     # Example #
     ```
     // Caching.instance
     ```
     */
    static var instance: Caching { get }
    
    /**
     Method for storing Data with a defined key.
     
     - parameter data: Data.
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.save(data: Data(), key: Cache.Key("data"))
     ```
     */
    func save(data: Data, key: Cache.Key)
    
    /**
     Method for storing Data with a defined key.
     
     - parameter data: T.
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.save(value: Codable, key: {key})
     ```
     */
    func save<T: Codable>(value: T, key: Cache.Key) throws
    
    /**
     Method for storing String with a defined key.
     
     - parameter data: String.
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.save(string: "data string", key: Cache.Key("string"))
     ```
     */
    func save(string: String, key: Cache.Key)
    
    /**
     Method for storing Boolean with a defined key.
     
     - parameter bool: Bool.
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.save(bool: true, key: Cache.Key("bool"))
     ```
     */
    func save(bool: Bool, key: Cache.Key)
    
    /**
     Method for storing Integer with a defined key.
     
     - parameter integer: Int.
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.save(integer: 101, key: Cache.Key("integer"))
     ```
     */
    func save(integer: Int, key: Cache.Key)
    
    /**
     Method for storing Array with a defined key.
     
     - parameter array: [Any].
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.save(array: [101, "string", true], key: Cache.Key("array"))
     ```
     */
    func save(array: [Any], key: Cache.Key)
    
    /**
     Method for storing Dictionary<String, Any> with a defined key.
     
     - parameter dictionary: [String: Any].
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.save(dictionary: ["bool": true, "integer": 101], key: Cache.Key("dictionary"))
     ```
     */
    func save(dictionary: [String: Any], key: Cache.Key)
    
    /**
     Method for storing Double with a defined key.
     
     - parameter double: Double.
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.save(double: 2.0, key: Cache.Key("double"))
     ```
     */
    func save(double: Double, key: Cache.Key)
    
    /**
     Method for storing Float with a defined key.
     
     - parameter float: Float.
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.save(float: 3.01, key: Cache.Key("float"))
     ```
     */
    func save(float: Float, key: Cache.Key)
    
    /**
     Method for getting Data with a defined key
     - parameter key: Cache.Key.
     - returns: T?
     
     # Example #
     ```
     // Caching.instance.readData(type: Codable.self, key: Cache.Key("data"))
     ```
     */
    func read<T: Codable>(type: T.Type, key: Cache.Key) throws -> T?
    
    /**
     Method for getting Data with a defined key
     - parameter key: Cache.Key.
     - returns: Data?
     
     # Example #
     ```
     // Caching.instance.readData(key: Cache.Key("data"))
     ```
     */
    func readData(key: Cache.Key) -> Data?
    
    /**
     Method for getting String with a defined key
     - parameter key: Cache.Key.
     - returns: String?
     
     # Example #
     ```
     // Caching.instance.readString(key: Cache.Key("string"))
     ```
     */
    func readString(key: Cache.Key) -> String?
    
    /**
     Method for getting Bool with a defined key
     - parameter key: Cache.Key.
     - returns: Bool?
     
     # Example #
     ```
     // Caching.instance.readBool(key: Cache.Key("bool"))
     ```
     */
    func readBool(key: Cache.Key) -> Bool?
    
    /**
     Method for getting Integer with a defined key
     - parameter key: Cache.Key.
     - returns: Int?
     
     # Example #
     ```
     // Caching.instance.readInteger(key: Cache.Key("integer"))
     ```
     */
    func readInteger(key: Cache.Key) -> Int?
    
    /**
     Method for getting Array with a defined key
     - parameter key: Cache.Key.
     - returns: [Any]?
     
     # Example #
     ```
     // Caching.instance.readArray(key: Cache.Key("array"))
     ```
     */
    func readArray(key: Cache.Key) -> [Any]?
    
    /**
     Method for getting Dictionary<String: Any> with a defined key
     - parameter key: Cache.Key.
     - returns: [String: Any]?
     
     # Example #
     ```
     // Caching.instance.readDictionary(key: Cache.Key("dictionary"))
     ```
     */
    func readDictionary(key: Cache.Key) -> [String: Any]?
    
    /**
     Method for getting Double with a defined key
     - parameter key: Cache.Key.
     - returns: Double?
     
     # Example #
     ```
     // Caching.instance.readDouble(key: Cache.Key("double"))
     ```
     */
    func readDouble(key: Cache.Key) -> Double?
    
    /**
     Method for getting Float with a defined key
     - parameter key: Cache.Key.
     - returns: Float?
     
     # Example #
     ```
     // Caching.instance.readFloat(key: Cache.Key("float"))
     ```
     */
    func readFloat(key: Cache.Key) -> Float?
    
    
    /**
     Method for deleting data stored with a defined key
     - parameter key: Cache.Key.
     
     # Example #
     ```
     // Caching.instance.remove(key: Cache.Key("dictionary"))
     ```
     */
    func remove(key: Cache.Key)
    
    /**
     Method for deleting all data stored via Caching with a defined key
     
     # Example #
     ```
     // Caching.instance.clear()
     ```
     */
    func clear()
}
