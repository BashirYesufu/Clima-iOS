//
//  WeatherManager.swift
//  Clima
//
//  Created by mac on 1/4/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?&appid=ab93f8ab58bdff69932f09dc12d7af26&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
   
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.list[0].main.temp
            let id = decodedData.list[0].weather[0].id
            let name = decodedData.list[0].name
            
            let weather = WeatherModel(cityName: name, conditionID: id, temperature: temp)
        } catch {
            
        }
    }
}
