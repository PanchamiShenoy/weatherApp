//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 02/02/22.
//

import Foundation

class HomeViewModel {
    let cityList = [CityNames.bangalore.rawValue,CityNames.mangalore.rawValue,CityNames.delhi.rawValue,CityNames.mumbai.rawValue]
    
    var locationList =  [WeatherResults]()
    func fetchData(city:String, completionHandler: @escaping (Error?)-> Void ) {
        
        NetworkManager().getDataWithCityName(city:city,completionHandler:{ [weak self] (weatherResults,errorReceieved) in
            if let errorReceieved = errorReceieved  {
                completionHandler(errorReceieved)
                return
            }
            guard let weatherResults = weatherResults else {
                return
            }
            self?.locationList.append(weatherResults)
            completionHandler(nil)
        })
        
    }
    
}
