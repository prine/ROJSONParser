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

    func getJSONValue(key:String) -> JSON {
        return jsonData[key]
    }
    
    func getValue(key:String) -> AnyObject {
        return jsonData[key].object
    }
    
    func getArray<T : ROJSONObject>(key:String) -> [T] {
        var elements = [T]()
        
        for jsonValue in getJSONValue(key).array! {
            var element = T.makeInstance() as T
            
            element.jsonData = jsonValue
            elements.append(element)
        }
        
        return elements
    }
    
    func getDate(key:String, dateFormatter:NSDateFormatter? = nil) -> NSDate? {
        // TODO: implement date parsing or use the helper class which is also included in the RASCOcloud
        return nil
    }
    
    class func makeInstance() -> ROJSONObject
    {
        return ROJSONObject()
    }
    
    class func makeInstance(jsonData:AnyObject) -> ROJSONObject
    {
        return ROJSONObject(jsonData:jsonData)
    }
}

class Value<T> {
    class func get(rojsonobject:ROJSONObject, key:String) -> T {
        return rojsonobject.getValue(key) as T
    }
    
    class func getArray<T : ROJSONObject>(rojsonobject:ROJSONObject, key:String? = nil) -> [T] {
        
        // If there is a key given fetch the array from the dictionary directly if not fetch all objects and pack it into an array
        if let dictKey = key {
            return rojsonobject.getArray(dictKey) as [T]
        } else {
            var objects = [T]()
            
            for jsonValue in rojsonobject.jsonData.array! {
                var object = T.makeInstance() as T
                object.jsonData = jsonValue
                objects.append(object)
            }
            
            return objects
        }
    }
    
    class func getDate(rojsonobject:ROJSONObject, key:String, dateFormatter:NSDateFormatter? = nil) -> NSDate? {
        return rojsonobject.getDate(key, dateFormatter: dateFormatter)
    }
}