//
//  x.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 03/02/22.
//

import UIKit

func getTimeInHrMin(timeZone: Int)-> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    formatter.amSymbol = "am"
    formatter.pmSymbol = "pm"
    formatter.timeZone = TimeZone(secondsFromGMT: timeZone)
    let dateString = formatter.string(from: Date())
    return dateString
}

func getAmOrPm(timeZone: Int)-> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "a"
    formatter.amSymbol = "am"
    formatter.pmSymbol = "pm"
    formatter.timeZone = TimeZone(secondsFromGMT: timeZone)
    let dateString = formatter.string(from: Date())
    return dateString
}
func getHr(timeZone: Int)-> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h"
    formatter.timeZone = TimeZone(secondsFromGMT: timeZone)
    let dateString = formatter.string(from: Date())
    return dateString
}

func getWeatherConditionIcon(weather: String)-> UIImage {
    switch weather {
    case WeatherCondition.smoke.rawValue :
        return UIImage(systemName: ImageSystemName.smoke.rawValue) ?? UIImage()
    case WeatherCondition.clouds.rawValue :
        return UIImage(systemName: ImageSystemName.cloud.rawValue) ?? UIImage()
    case WeatherCondition.clear.rawValue :
        return UIImage(systemName: ImageSystemName.clear.rawValue) ?? UIImage()
    case WeatherCondition.haze.rawValue :
        return UIImage(systemName: ImageSystemName.haze.rawValue) ?? UIImage()
    case WeatherCondition.mist.rawValue :
        return UIImage(systemName: ImageSystemName.haze.rawValue) ?? UIImage()
    default:
        return UIImage()
    }
}
func fahrenheitToCelsius(temperature: Float )-> Float {
    let tempinCelsius = round((temperature - 32) / 1.8 )
    return tempinCelsius
    
}
