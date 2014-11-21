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
        
        var urlToJSON = "http://prine.ch/employeesWithout.json"
        
        baseWebservice.get(urlToJSON, callback: { (status, employeeContainer:EmployeeContainer) -> () in
            println(employeeContainer.employees[0].firstname)
            println(employeeContainer.employees[0].lastname)
            
            println("Firstname: " + employeeContainer.employees[0].firstname)
            println("Lastname: " + employeeContainer.employees[0].firstname)
            println("Age: \(employeeContainer.employees[0].age)")

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

