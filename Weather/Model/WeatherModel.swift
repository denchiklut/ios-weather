//
//  WeatherModel.swift
//  Weather
//
//  Created by Александров Денис Александрович on 14.02.2020.
//  Copyright © 2020 Александров Денис Александрович. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let sourceTemp: Double
    let id: Int
    
    var temp: String {
        return String("\(Int(sourceTemp))")
    }
    
    var weatherImg: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
