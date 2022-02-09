//
//  SecondWeather.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 03/02/22.
//

import Foundation

struct SecondWeatherResults: Codable {
    let hourly: [HourlyDetails]
}
struct HourlyDetails: Codable {
    let dewPoint: Float
    let uvi: Float
    let clouds: Float
}
