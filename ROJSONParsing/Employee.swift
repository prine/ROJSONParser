//
//  Employee.swift
//  ROJSONParsing
//
//  Created by Robin Oster on 08/08/14.
//  Copyright (c) 2014 Robin Oster. All rights reserved.
//

import Foundation

class Employee : ROJSONObject {

    required init() {
        super.init();
    }
    
    required init(jsonData:AnyObject) {
        super.init(jsonData: jsonData)
    }
    
    var firstname:String {
        return Value<String>.get(self, key: "firstName")
    }
    
    var lastname:String {
        return Value<String>.get(self, key: "lastName")            
    }
    
    var age:Int {
        return Value<Int>.get(self, key: "age")
    }
    
    override class func makeInstance() -> ROJSONObject
    {
        return Employee()
    }
    
    override class func makeInstance(jsonData:AnyObject) -> ROJSONObject
    {
        return Employee(jsonData:jsonData)
    }
}