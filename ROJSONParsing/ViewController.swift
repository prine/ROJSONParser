//
//  ViewController.swift
//  ROJSONParsing
//
//  Created by Robin Oster on 07/08/14.
//  Copyright (c) 2014 Robin Oster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        var baseWebservice:BaseWebservice = BaseWebservice();
        
        var urlToJSON = "http://prine.ch/employees.json"
        
        var callbackJSON = {(status:Int, employeeContainer:EmployeeContainer) -> () in
            println(employeeContainer.employees[0].firstname)
            println(employeeContainer.employees[1].firstname)
            
            for employee in employeeContainer.employees {
                println("Firstname: \(employee.firstname) Lastname: \(employee.lastname) age: \(employee.age)");
            }
        }
        
        baseWebservice.get(urlToJSON, callback:callbackJSON)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

