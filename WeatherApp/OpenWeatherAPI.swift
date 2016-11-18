//
//  OpenWeatherAPI.swift
//  WeatherApp
//
//  Created by shashank kannam on 11/11/16.
//  Copyright © 2016 shashank kannam. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/forecast?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "84367f2140c8f9873aa45330eb7f2bab"

let CURRENT_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedLocation.latitude!)\(LONGITUDE)\(Location.sharedLocation.longitude!)\(APP_ID)\(API_KEY)"

 typealias DownloadCompleted = () -> ()

let FBASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let FLATITUDE = "lat="
let FLONGITUDE = "&lon="
let FAPP_ID = "&appid="
let FAPI_KEY = "84367f2140c8f9873aa45330eb7f2bab"
let FCURRENT_URL = "\(FBASE_URL)\(FLATITUDE)\(Location.sharedLocation.latitude!)\(FLONGITUDE)\(Location.sharedLocation.longitude!)&cnt=10&mode=json\(FAPP_ID)\(FAPI_KEY)"

//typealias DownloadCompleted = () -> ()
