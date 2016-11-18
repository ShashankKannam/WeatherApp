//
//  Location.swift
//  WeatherApp
//
//  Created by shashank kannam on 11/14/16.
//  Copyright © 2016 shashank kannam. All rights reserved.
//

import Foundation
import CoreLocation

class Location{
    
    static var sharedLocation:Location = Location()
//    
//    private init(){
//        
//    }
    var latitude:Double!
    var longitude:Double!
}
