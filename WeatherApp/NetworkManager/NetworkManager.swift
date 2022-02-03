//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 02/02/22.
//

import Foundation

final class NetworkManager{
    static let shared = NetworkManager()
    var newData:weatherResults?
    func getData(city:String,completionHandler:@escaping (weatherResults)->Void ){
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=feafb47733712f2cb5c98310fa3a92a6"
        guard let urlToSend = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlToSend) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.newData = try decoder.decode(weatherResults.self, from: data)
                }catch{
                    print("failed",error.localizedDescription)
                }
            }
            guard let json = self.newData else{
                return
            }
            completionHandler(json)
        }
        task.resume()
       
    }

}
