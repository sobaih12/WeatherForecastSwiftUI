//
//  Network.swift
//  WeatherForecast-SwiftUI
//
//  Created by Mostfa Sobaih on 12/05/2024.
//

import Foundation

class Network {
    static func fetchWeather(lat :String,lon :String, completion: @escaping (WeatherResponse?) -> Void) {
       
        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?appid=a3f635d13b2c152303920e2b53093f0b&lat=\(lat)&lon=\(lon)&units=metric") else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(result)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        task.resume()
    }
    static func fetchHourly(lat :String,lon :String, completion: @escaping (HoursResponse?) -> Void) {
       
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=57d0921d2ce54c4496c75056241205&q=\(lat),\(lon)&days=3&aqi=yes&alerts=no") else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(HoursResponse.self, from: data)
                completion(result)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        task.resume()
    }
}
