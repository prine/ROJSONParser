//
//  BaseWebservice.swift
//  ROJSONParsing
//
//  Created by Robin Oster on 11/06/14.
//  Copyright (c) 2014 Robin Oster. All rights reserved.
//

import Foundation
import Alamofire

class BaseWebservice {

    /**
    *  Get method for fetching the data from the webservice
    *
    *  @param urlString:String Urlto the REST webservice entry
    *  @param callback:Int     HTTP Response status code
    *  @param AnyObject!       ROJSONObject Object
    *
    */
    func get(urlString:String, callback:(Int, AnyObject?) -> (), parameters:[String : AnyObject!]? = nil) {
        Alamofire.request(.GET, urlString, parameters: parameters).responseJSON {(request, response, JSON, error) in
            callback(response!.statusCode, JSON)
        }
    }
    
    /**
    *  Generic get method which creates automatically the ROJSONObjects from the given JSON response
    *
    *  @param urlString:String Url to the REST webservice entry
    *  @param Int              HTTP Response status code
    *  @param T                ROJSONObject Object
    *
    */
    func get<T:ROJSONObject>(urlString:String, callback: (Int, T) -> ()) {
        
        var webserviceCallback = {(status:Int, response:AnyObject?) -> () in
            callback(status, T.makeInstance(response!) as T)
        }
        
        self.get(urlString, callback: webserviceCallback)
    }
}