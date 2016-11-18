//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by shashank kannam on 11/12/16.
//  Copyright © 2016 shashank kannam. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather{
    private var _currentDate:String!
    private var _currentTemp:Double!
    private var _currentLocation:String!
    private var _currentTempType:String!
    
    var currentDate:String{
                if _currentDate==nil{
            _currentDate=""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        _currentDate = "Today, \(dateFormatter.string(from: Date()))"
        
        return _currentDate
    }
    
    var currentLocation:String{
        if _currentLocation==nil{
            _currentLocation=""
        }
        
        return _currentLocation
    }
    
    var currentTempType:String{
        if _currentTempType==nil{
            _currentTempType=""
        }
        
        return _currentTempType
    }
    
    var currentTemp:Double{
        if _currentTemp==nil{
            _currentTemp=0.0
        }
        return _currentTemp
    }

    func downloadData(completed: @escaping DownloadCompleted){
       //@escaping before parameter DownloadComplete
        Alamofire.request(CURRENT_URL).responseJSON { response in
           // print(response.request)  // original URL request
            print(response.response) // HTTP URL response
           // print(response.data)     // server data
           // print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
               // print("JSON: \(JSON)")
                if let mainData = JSON as? Dictionary<String, Any>{
                    
        //-----------cityName------------
                    if let city = mainData["city"] as? Dictionary<String, Any>{
                        //print(city["name"] as! String)
                        if let cl = city["name"] as? String{
                            self._currentLocation = cl.capitalized
                            
                        }
                       
                    }
        //-----------Temperatures------------
                    if let list = mainData["list"] as? [Dictionary<String, Any>]{
                      
if let currentWeatherDetails = list[0] as? Dictionary<String, Any>{
                          //--------current temperature in Farenheit
                            if let main = currentWeatherDetails["main"] as? Dictionary<String, Any>{
                                //T(°F) = T(K) × 9/5 - 459.67
                               self._currentTemp = round((main["temp"] as! Double)*9/5 - 459.67)
                                

                            }
        //-------------Weather type--------
            if let weather = currentWeatherDetails["weather"] as? [Dictionary<String, Any>]{
              if let weatherNow = weather[0] as? Dictionary<String, Any>{
                if let cTT = weatherNow["main"] as? String{
                    self._currentTempType = cTT.capitalized
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
            
            
            completed()
            print(self.currentLocation)
            print(self.currentTemp)
            print(self.currentTempType)
            print(self.currentDate)

        }

  
    }
    
    
    }
