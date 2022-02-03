//
//  HomeViewConstants.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 02/02/22.
//

import Foundation

enum imageAssetName: String {
    case bangalore = "bangalore"
    case mangalore = "mangalore"
    case delhi = "delhiIndia"
    case bombay = "bombay"
    case homeBackground = "background"
}

enum imageSystemName: String {
    case drizzle = "cloud.drizzle"
    case rain = "cloud.rain"
    case cloud = "cloud"
    case snow = "cloud.snow"
    case haze = "sun.haze"
    case clear = "cloud.sun"
    case smoke = "smoke"
}
enum cityNames: String {
    case delhi = "Delhi"
    case mumbai = "Mumbai"
    case bangalore = "Bengaluru"
    case mangalore = "Mangalore"
}
enum weatherCondition: String {
    case smoke = "Smoke"
    case haze = "Haze"
    case clouds = "Clouds"
    case clear = "Clear"
    
}
enum cellIdentifier: String {
    case locationCell = "locationCell"
}

//enum urlList: String{
//    case apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=feafb47733712f2cb5c98310fa3a92a6"
//}
