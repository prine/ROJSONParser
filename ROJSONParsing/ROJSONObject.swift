//
//  JSONObject.swift
//  RASCOcloud
//
//  Created by Robin Oster on 02/07/14.
//  Copyright (c) 2014 Robin Oster. All rights reserved.
//

import Foundation

class ROJSONObject {
    
    var jsonData:JSON
    
    required init() {
        // Default constructor
        jsonData = []
    }
    
    required init(jsonData:AnyObject) {
        self.jsonData = JSON(jsonData)
    }

    func getJSONValue(key:String) -> JSValue {
        return jsonData[key]
    }
    
    func getValue(key:String) -> Any {
        
        var jsonValue = jsonData[key]
        
        switch jsonValue {
        case .JSBool(let bool):
            return jsonValue.bool!
            
        case .JSNumber(let number):
            if ceil(number) == number {
                return Int(number)
            } else {
                return number
            }
            
        case .JSString(let string):
            return jsonValue.string!
            
        case .JSArray(let array):
            return jsonValue.array!
            
        case .JSObject(let dict):
            return jsonValue.object!
            
        case .JSNull:
            return "null"
            
        default:
            assert(true, "This should never be reached")
            return ""
        }
    }
    
    func getArray<T : ROJSONObject>(key:String) -> [T] {
        var elements = [T]()
        
        for jsonValue in getJSONValue(key).array! {
            var element = T()
            
            element.jsonData = jsonValue
            elements.append(element)
        }
        
        return elements
    }
    
    func getDate(key:String, dateFormatter:NSDateFormatter? = nil) -> NSDate? {
        // TODO: implement date parsing or use the helper class which is also included in the RASCOcloud
        return nil
    }
}

class Value<T> {
    class func get(rojsonobject:ROJSONObject, key:String) -> T {
        return rojsonobject.getValue(key) as T
    }
    
    class func getArray<T : ROJSONObject>(rojsonobject:ROJSONObject, key:String) -> [T] {
        return rojsonobject.getArray(key) as [T]
    }
    
    class func getDate(rojsonobject:ROJSONObject, key:String, dateFormatter:NSDateFormatter? = nil) -> NSDate? {
        return rojsonobject.getDate(key, dateFormatter: dateFormatter)
    }
}