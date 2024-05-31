//
//  Utils.swift
//  WeatherForecast-SwiftUI
//
//  Created by Mostfa Sobaih on 12/05/2024.
//

import Foundation
import UIKit
import CoreLocation

class Utils {
    static func dayOfWeek(fromTimestamp timestamp: TimeInterval) -> String? {
        let date = Date(timeIntervalSince1970: timestamp)
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE"
        if let weekdayDate = calendar.date(bySetting: .weekday, value: dayOfWeek, of: date) {
            return dateFormatter.string(from: weekdayDate)
        } else {
            return nil
        }
    }
    
    static func timeAndIsDay(fromTimestamp timestamp: TimeInterval) -> Bool {
        let date = Date(timeIntervalSince1970: timestamp)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "h:mm a"
        let isDay = (hour >= 5 && hour < 18)
        return isDay
    }
    
    static func getImage(imageCode: String) -> UIImage? {
        switch imageCode {
        case "01d":
            return UIImage(named: "clear_sky_day_1")
        case "01n":
            return UIImage(named: "clear_sky_night")
        case "02d", "03d", "04d":
            return UIImage(named: "clouds_day")
        case "02n", "03n", "04n":
            return UIImage(named: "clouds_night")
        case "09d", "10d":
            return UIImage(named: "rain_day")
        case "09n", "10n":
            return UIImage(named: "rain_night")
        case "11d":
            return UIImage(named: "thunder_day")
        case "11n":
            return UIImage(named: "thunder_night")
        case "13d":
            return UIImage(named: "snow_day")
        case "13n":
            return UIImage(named: "snow_night")
        case "50d":
            return UIImage(named: "mist_day")
        case "50n":
            return UIImage(named: "mist_night")
        default:
            return nil
        }
    }
    static func getImageFromUrl(imageCode: Double) -> UIImage? {
        switch imageCode {
        case 1000:
            return UIImage(named: "clear_sky_day_1")
        case 1009:
            return UIImage(named: "clear_sky_night")
        case 1003,1006:
            return UIImage(named: "clouds_day")
        case 1279:
            return UIImage(named: "clouds_night")
        case 1063,1180,1189:
            return UIImage(named: "rain_day")
        case 1135,1183,1186,1192,1195,1198:
            return UIImage(named: "rain_night")
        case 1072:
            return UIImage(named: "thunder_day")
        case 1087:
            return UIImage(named: "thunder_night")
        case 1066,1213:
            return UIImage(named: "snow_day")
        case 1114,1147,1222:
            return UIImage(named: "snow_night")
        case 1030:
            return UIImage(named: "mist_day")
        case 1117:
            return UIImage(named: "mist_night")
        default:
            print(imageCode)
            return UIImage(named: "snow_night")
        }
    }
    
    static func getAddressEnglish(lat: Double, lon: Double, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed with error: \(error.localizedDescription)")
                completion(nil)
            } else if let placemark = placemarks?.first {
                var result = ""
                if let adminArea = placemark.administrativeArea {
                    result += adminArea
                }
                if let country = placemark.country {
                    if !result.isEmpty {
                        result += ", "
                    }
                    result += country
                }
                result = result.replacingOccurrences(of: " Governorate", with: "")
                completion(result)
            } else {
                completion("Unknown location")
            }
        }
    }
    static func extractTime(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: dateString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            return timeFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
