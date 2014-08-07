ROJSONParser
============

Is a very light-weight and straighforward JSON to Object-Mapper. You can define your class structure and directly
define in there your accessed properties in the JSON file. The whole parsing of the JSON file is done by the awesome work of David Owens (https://github.com/owensd/json-swift).

Example Employees.json

```json
{
"employees": [
  {
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

    lazy var employees:[Employee] = {
        return Value<[Employee]>.getArray(self, key: "employees") as [Employee]
    }()
}
```

Then to actually map the objects from the JSON response you only have to pass the data into the EmployeeContainer class as param in the constructor. It does automatically create your data model.

```swift
  var baseWebservice:BaseWebservice = BaseWebservice();
        
        var urlToJSON = "http://prine.ch/employees.json"
        
        var callbackJSON = {(status:Int, jsonResponse:AnyObject!) -> () in
            var employeeContainer:EmployeeContainer = EmployeeContainer(jsonData: jsonResponse)
            
            println(employeeContainer.employees[0].firstname)
            println(employeeContainer.employees[1].firstname)
            
            for employee in employeeContainer.employees {
                println("Firstname: \(employee.firstname) Lastname: \(employee.lastname) age: \(employee.age)");
            }
        }
        
        baseWebservice.get(urlToJSON, callback:callbackJSON)
    }
```


The console output looks then like the following:

```txt
John
Anna
Firstname: John Lastname: Doe age: 26
Firstname: Anna Lastname: Smith age: 30
Firstname: Peter Lastname: Jones age: 45
```
