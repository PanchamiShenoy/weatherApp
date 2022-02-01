//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 01/02/22.
//

import Foundation

class WeatherDetail {
    var cityName: String
    var cityTime: String
    var cityTemperature: String
    var cityWeather: String
    
    init(name:String,time:String,temp:String,weather:String){
        cityName = name
        cityTime = time
        cityTemperature = temp
        cityWeather = weather
        
    }
    
}
