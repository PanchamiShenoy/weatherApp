//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 02/02/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    var newData: WeatherResults?
    var decodedData: SecondWeatherResults?
    
    func getDataWithCityName(city: String, completionHandler: @escaping (WeatherResults?,Error?)-> Void ) {
        let url = "\(Url.baseUrl.rawValue)/weather?q=\(city)\(Url.apiKey.rawValue)"
        
        guard let urlToSend = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlToSend) { data, response, error in
            if let error = error {
                completionHandler(nil,error)
            }
            
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.newData = try decoder.decode(WeatherResults.self, from: data)
                }catch{
                    print("failed",error.localizedDescription)
                }
            }
            guard let decodedResults = self.newData else{
                return
            }
            completionHandler(decodedResults,nil)
        }
        task.resume()
        
    }
    
    func getDetailsWithCoordinates(lat: Float,long: Float,completionHandler: @escaping (SecondWeatherResults)-> Void ) {
        let url = "\(Url.baseUrl.rawValue)/onecall?lat=\(lat)&lon=\(long)\(Url.apiKey.rawValue)"
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
                    self.decodedData = try decoder.decode(SecondWeatherResults.self, from: data)
                }catch{
                    print("failed",error.localizedDescription)
                }
            }
            guard let decodedResults = self.decodedData else{
                return
            }
            completionHandler(decodedResults)
        }
        task.resume()
        
    }
}
