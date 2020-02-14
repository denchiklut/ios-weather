//
//  ViewController.swift
//  Weather
//
//  Created by Александров Денис Александрович on 12.02.2020.
//  Copyright © 2020 Александров Денис Александрович. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        weatherManager.delegate = self
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchField.endEditing(true)
    }
}

extension WeatherController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "Enter city name"
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            weatherManager.fetchWeather(with: city)
        }
        searchField.text = ""
    }
}

extension WeatherController: WeatherMangerDelegate {
    func weatherDidUpdate(_ weatherManager: WeatherManger, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temp
            self.weatherImage.image = UIImage(systemName: weather.weatherImg)
        }
    }
    
    func weatherDidFail(_ weatherManager: WeatherManger, error: Error) {
        print(error)
    }
    
    
}

