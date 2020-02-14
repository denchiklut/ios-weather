//
//  WeatherData.swift
//  Weather
//
//  Created by Александров Денис Александрович on 14.02.2020.
//  Copyright © 2020 Александров Денис Александрович. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
