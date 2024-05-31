//
//  HourModels.swift
//  WeatherForecast-SwiftUI
//
//  Created by Mostfa Sobaih on 12/05/2024.
//

import Foundation

struct HoursResponse :Codable{
    var forecast : Forecast?
}
struct Forecast :Codable{
    var forecastday : [ForecastDay]?
}
struct ForecastDay :Codable{
    var hour : [Hours]?
}
struct Hours :Codable{
    var temp_c : Double?
    var time : String?
    var condition : Condition?
}
struct Condition : Codable {
    var text : String?
    var code : Double?
}
