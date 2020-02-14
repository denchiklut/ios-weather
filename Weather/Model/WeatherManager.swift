//
//  WeatherModel.swift
//  Weather
//
//  Created by Александров Денис Александрович on 14.02.2020.
//  Copyright © 2020 Александров Денис Александрович. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherMangerDelegate {
    func weatherDidUpdate(_ weatherManager: WeatherManger, weather: WeatherModel)
    func weatherDidFail(_ weatherManager: WeatherManger, error: Error)
}

struct WeatherManger {
    let apiURL = "https://api.openweathermap.org/data/2.5/weather?appid=e7082d1900832c8867e057e99228643f&units=metric"
    var delegate: WeatherMangerDelegate?
    
    func fetchWeather(with city: String) {
        let url = "\(apiURL)&q=\(city)"
        perfomeRequest(with: url)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let url = "\(apiURL)&lat=\(lat)&lon=\(lon)"
        perfomeRequest(with: url)
    }
    
    func perfomeRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.weatherDidFail(self, error: error!)
                } else {
                    if let safeData = data {
                        if let weather = self.parseData(data: safeData) {
                            self.delegate?.weatherDidUpdate(self, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseData(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            let cityName = weatherData.name
            let temp = weatherData.main.temp
            let id = weatherData.weather[0].id
            
            return WeatherModel(cityName: cityName, sourceTemp: temp, id: id)
            
        } catch {
            delegate?.weatherDidFail(self, error: error)
            return nil
        }
    }
}
