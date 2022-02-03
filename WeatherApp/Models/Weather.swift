//
//  Weather.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 02/02/22.
//

import Foundation

struct weatherResults: Codable {
    let weather: [weatherDetails]
    let main: mainDetails
    let visibility: Int
    let wind: windDetails
    let clouds: cloudDetails
    let name :String
    let timezone: Int
}
struct weatherDetails:Codable {
    let main: String
}
struct mainDetails: Codable {
    let temp: Float
    let feelsLike: Float
    let pressure: Int
    let humidity: Int
}

struct windDetails: Codable{
    let speed : Float
}

struct cloudDetails : Codable {
    let all : Int
}
