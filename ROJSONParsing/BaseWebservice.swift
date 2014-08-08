//
//  BaseWebservice.swift
//  ROJSONParsing
//
//  Created by Robin Oster on 11/06/14.
//  Copyright (c) 2014 Robin Oster. All rights reserved.
//

import Foundation

class BaseWebservice {

    func get(urlString: String, callback: (Int, AnyObject!) -> ()) {
        
        // Make the asynchronous call
        var sessionConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        sessionConfig.timeoutIntervalForRequest = 60
        sessionConfig.timeoutIntervalForResource = 60
        sessionConfig.requestCachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        
        var session = NSURLSession(configuration: sessionConfig)
        
        var completionHandler = { (data: NSData?, urlResponse: NSURLResponse?, error: NSError?) -> () in
            
            if let httpResponse = urlResponse as? NSHTTPURLResponse {
                if(error == nil && httpResponse.statusCode == 200) {
                    
                    var jsonParsingError: NSError?
                    
                    var unwrappedJSON : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonParsingError)
                    
                    // If the JSON could be parsed, map it into a dict or an array
                    if jsonParsingError == nil {
                        
                        // Check if its an NSArray or NSDictionary
                        if let parsedJSONArray = unwrappedJSON as? [AnyObject] {
                            // Is an JSON Array
                            // DDLogWrapper.logVerbose("\(parsedJSONArray)")
                            callback(httpResponse.statusCode, parsedJSONArray)
                        } else {
                            if let parsedJSONDict = unwrappedJSON as? NSDictionary {
                                // If the structure is a Dictionary wrap it into an array
                                // var arrayWrapper = AnyObject[]()
                                // arrayWrapper.append(parsedJSONDict)
                                
                                callback(httpResponse.statusCode, parsedJSONDict)
                            } else {
                                // Unknown type
                                println("Unknown JSON Format type")
                            }
                        }
                    } else {
                        callback(httpResponse.statusCode, NSString(data: data, encoding: NSUTF8StringEncoding))
                    }
                }
            } else {
                println("Http Response not correctly received!")
            }
        }
        
        var url: NSURL? = NSURL(string : urlString)
        
        session.dataTaskWithURL(url, completionHandler: completionHandler).resume()
        
        // Pass the data through the callback back to the sender
        
    }
}