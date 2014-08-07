//
//  EmployeeContainer.swift
//  ROJSONParsing
//
//  Created by Robin Oster on 08/08/14.
//  Copyright (c) 2014 Robin Oster. All rights reserved.
//

import Foundation

class EmployeeContainer : ROJSONObject {
    required init() {
        super.init();
    }

    required init(jsonData:AnyObject) {
        super.init(jsonData: jsonData)
    }

    lazy var employees:[Employee] = {
        return Value<[Employee]>.getArray(self, key: "employees") as [Employee]
    }()
}