//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by shashank kannam on 11/13/16.
//  Copyright © 2016 shashank kannam. All rights reserved.
//

import Foundation

class ForecastWeather{
    private var _date:String!
    private var _FTempType:String!
    private var _HighTemp:Double!
    private var _LowTemp:Double!

    
    
    var date:String{
        if _date==nil{
            _date=""
        }
        return _date
    }
    
    var fTempType:String{
        if _FTempType==nil{
            _FTempType=""
        }
        
        return _FTempType
    }
    
    
    var highTemp:Double{
        if _HighTemp==nil{
            _HighTemp=0.0
        }
        return _HighTemp
    }
    
    var lowTemp:Double{
        if _LowTemp==nil{
            _LowTemp=0.0
        }
        return _LowTemp
    }

    init(weatherDict: Dictionary<String, Any>){
        
        if let date = weatherDict["dt"] as? Double {
            
            let dateformatterk = DateFormatter()
            dateformatterk.dateStyle = .full
            dateformatterk.timeStyle = .none
            dateformatterk.dateFormat="EEEE"
            let convertedDatek = Date(timeIntervalSince1970:date)
            self._date = dateformatterk.string(from: convertedDatek)
        }

        
        if let temp = weatherDict["temp"] as? Dictionary<String, Any>{
            if let min = temp["min"] as? Double{
                self._LowTemp = round(min*9/5 - 459.67)
            }
            if let max = temp["max"] as? Double{
                self._HighTemp = round(max*9/5 - 459.67)
            }
        }
       
        if let tempType = weatherDict["weather"] as? [Dictionary<String, Any>]{
            if let temperatuteType = tempType[0]["main"] as? String{
                self._FTempType = temperatuteType.capitalized
            }
        }
        
       print(date)
        print("low temp:\(lowTemp)")
        print(highTemp)
        print(fTempType)
        
    }
}




