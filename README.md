ROJSONParser
============

Is a very light-weight and straighforward JSON to object mapper. You can define your class structure and directly
define in there your accessed properties in the JSON file. The whole parsing of the JSON file is done by the library SwiftyJSON https://github.com/SwiftyJSON/SwiftyJSON.

Example Employees.json

```json
{
  [{
    "firstName": "John",
    "lastName": "Doe",
    "age": 26
  },
  {
    "firstName": "Anna",
    "lastName": "Smith",
    "age": 30
  },
  {
    "firstName": "Peter",
    "lastName": "Jones",
    "age": 45
  }]
}
```

As next step you have to create your data model (EmplyoeeContainer and Employee).

Employee.swift
````swift
class Employee : ROJSONObject {

    required init() {
        super.init();
    }
    
    required init(jsonData:AnyObject) {
        super.init(jsonData: jsonData)
    }
    
    required init(jsonString: String) {
        super.init(jsonString:jsonString)
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
}
```

EmployeeContainer.swift
```swift
class EmployeeContainer : ROJSONObject {
    required init() {
        super.init();
    }

    required init(jsonData:AnyObject) {
        super.init(jsonData: jsonData)
    }

    required init(jsonString: String) {
        super.init(jsonString:jsonString)
    }

    lazy var employees:[Employee] = {
        return Value<[Employee]>.getArray(self) as [Employee]
    }()
}
```

Then to actually map the objects from the JSON response you only have to pass the data into the EmployeeContainer class as param in the constructor. It does automatically create your data model.

```swift
  var baseWebservice:BaseWebservice = BaseWebservice();
  
  var urlToJSON = "http://prine.ch/employeesWithout.json"
  
  baseWebservice.get(urlToJSON, callback: { (status, employeeContainer:EmployeeContainer) -> () in
      println(employeeContainer.employees[0].firstname)
      println(employeeContainer.employees[0].lastname)
      
      println("Firstname: " + employeeContainer.employees[0].firstname)
      println("Lastname: " + employeeContainer.employees[0].firstname)
      println("Age: \(employeeContainer.employees[0].age)")

  })
```


The console output looks then like the following:

```txt
John
Doe
Firstname: John
Lastname: John
Age: 26
```

Installation
---
To use the library you need to clone the Alamofire Framework in the same dictionary where the ROJSONParser is. For further installation guidance visit https://github.com/Alamofire/Alamofire#installation. Futher instructions for the SwiftyJSON Library visit https://github.com/SwiftyJSON/SwiftyJSON#integration
