//
//  ViewController.swift
//  WeatherApp
//
//  Created by shashank kannam on 11/10/16.
//  Copyright © 2016 shashank kannam. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    var weatherData:CurrentWeather!
    
    var forecasts:[ForecastWeather]!
    
    var forecast:ForecastWeather!
    
    var locationManager = CLLocationManager()
    
    var currentLocation:CLLocation!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate=self
        tableView.dataSource=self
        locationManager.delegate=self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        //self.locationAuthStatus()
        
        weatherData = CurrentWeather()
        
        forecasts = [ForecastWeather]()
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
           self.locationAuthStatus()
    }

    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedLocation.latitude = currentLocation.coordinate.latitude
            Location.sharedLocation.longitude = currentLocation.coordinate.longitude
           // print("im here........\(Location.sharedLocation.latitude) and \(Location.sharedLocation.longitude)")
           
            weatherData.downloadData {
                //
                
                self.updateForeCastUI(completed: {
                    //
                    self.updateMainUI()
                })
                
                
            }
        }
        else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var currentTempLable: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentImg: UIImageView!
    
    @IBOutlet weak var tempType: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func updateMainUI(){
        tempType.text = weatherData.currentTempType
        dateLabel.text = weatherData.currentDate
        currentTempLable.text = "\(weatherData.currentTemp)°"
        locationLabel.text = weatherData.currentLocation
        currentImg.image = UIImage(named: weatherData.currentTempType)
    }
    
    func updateForeCastUI(completed: @escaping DownloadCompleted){
        let forecastURL = URL(string: FCURRENT_URL)!
        //@escaping before parameter DownloadComplete
        Alamofire.request(forecastURL).responseJSON { response in
            // print(response.request)  // original URL request
            // print(response.response) // HTTP URL response
            // print(response.data)     // server data
            // print(response.result)   // result of response serialization
            
    if let JSON = response.result.value {
        // print("JSON: \(JSON)")
        if let mainData = JSON as? Dictionary<String, Any>{
            if let list = mainData["list"] as? [Dictionary<String, Any>]{
                for obj in list{
                    
                    self.forecasts.append(ForecastWeather(weatherDict: obj))
                }
                self.forecasts.remove(at: 0)
                self.tableView.reloadData()
            }
                            }
        completed()
                }
            
    }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastWeatherTableViewCell{
            
            cell.configureCell(forecastWeather: forecasts[indexPath.row])
            
            return cell

        }
        else{
            return ForecastWeatherTableViewCell()
        }
            }
    
    
}


