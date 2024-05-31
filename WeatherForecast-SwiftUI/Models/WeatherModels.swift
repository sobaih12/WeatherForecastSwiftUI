//
//  WeatherModels.swift
//  WeatherForecast-SwiftUI
//
//  Created by Mostfa Sobaih on 12/05/2024.
//

import Foundation

struct WeatherResponse : Codable {
    var lat : Double
    var lon : Double
    var timezone : String?
    var current : Current?
    var daily : [Daily]?
}

struct Current : Codable {
    var dt : Double?
    var temp : Double?
    var feels_like : Double?
    var pressure : Int?
    var humidity : Int?
    var visibility : Int?
    var wind_speed : Double?
    var weather : [Weather]?
}

struct Weather : Codable {
    var id : Int?
    var main : String?
    var description : String?
    var icon : String?
}


struct Daily : Codable {
    var dt : Double?
    var temp : Temp?
    var weather : [Weather]?
}

struct Temp : Codable{
    var min : Double?
    var max : Double?
}
