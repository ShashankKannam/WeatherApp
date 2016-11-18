//
//  ForecastWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by shashank kannam on 11/13/16.
//  Copyright © 2016 shashank kannam. All rights reserved.
//

import UIKit

class ForecastWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var fThumbNail: UIImageView!
    
    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var weatherType: UILabel!
    
    @IBOutlet weak var highTemp: UILabel!
    
    @IBOutlet weak var lowTemp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(forecastWeather:ForecastWeather){
        fThumbNail.image = UIImage(named: forecastWeather.fTempType)
        weatherType.text = forecastWeather.fTempType
        day.text = forecastWeather.date
        highTemp.text = "\(forecastWeather.highTemp)°"
        lowTemp.text = "\(forecastWeather.lowTemp)°"
    }
    
    
}
