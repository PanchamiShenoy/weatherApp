//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 02/02/22.
//

import Foundation

class HomeViewModel{
    var locationList =  [weatherResults]()
    func fetchData(city:String,completionHandler:@escaping ()->Void ){
        
        NetworkManager().getData(city:city,completionHandler:{ [weak self] (weatherResults) in
            print(weatherResults.name)
            self!.locationList.append(weatherResults)
            completionHandler()
        })
        
    }

}
