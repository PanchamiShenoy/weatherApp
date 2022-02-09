
//  weatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 03/02/22.


import Foundation

class WeatherDetailViewModel {
    var weatherDetails: WeatherResults?
    var secondWeatherDetails: SecondWeatherResults?
    let weatherDetailsKeys = [WeatherDetailKey.feelsLike.rawValue, WeatherDetailKey.pressure.rawValue,WeatherDetailKey.humidity.rawValue, WeatherDetailKey.visibilty.rawValue, WeatherDetailKey.windSpeed.rawValue, WeatherDetailKey.clouds.rawValue, WeatherDetailKey.dewPoint.rawValue, WeatherDetailKey.uvi.rawValue]
    var weatherDetailValues = [String]()
    
    func fetchDataWithCityName(city: String, completionHandler: @escaping ()->Void ){
        NetworkManager().getDataWithCityName(city:city,completionHandler:{ [weak self] (weatherResults,errorReceived) in
            self?.weatherDetails = weatherResults
            guard let validWeatherDetails = self?.weatherDetails else {
                return
            }
            self?.weatherDetailValues.append("\(validWeatherDetails.main.feelsLike)")
            self?.weatherDetailValues.append("\(validWeatherDetails.main.pressure)")
            self?.weatherDetailValues.append("\(validWeatherDetails.main.humidity)")
            self?.weatherDetailValues.append("\(validWeatherDetails.visibility)")
            self?.weatherDetailValues.append("\(validWeatherDetails.wind.speed)")
            completionHandler()
        })
        
    }
    func fetchDataWithCoord(lat:Float, long:Float, completionHandler:@escaping ()->Void ){
        
        NetworkManager().getDetailsWithCoordinates(lat:lat,long:long,completionHandler:{ [weak self] (secondWeatherDetails) in
            self?.secondWeatherDetails = secondWeatherDetails
            guard let validExtraDetail = self?.secondWeatherDetails else {
                return
            }
            self?.weatherDetailValues.append("\(validExtraDetail.hourly[0].clouds)")
            self?.weatherDetailValues.append("\(validExtraDetail.hourly[0].dewPoint)")
            self?.weatherDetailValues.append("\(validExtraDetail.hourly[0].uvi)")
            completionHandler()
        })
        
    }
}
