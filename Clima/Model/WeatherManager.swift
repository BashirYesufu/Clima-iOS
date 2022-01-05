//
//  WeatherManager.swift
//  Clima
//
//  Created by mac on 1/4/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func updateViews(_ weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?&appid=ab93f8ab58bdff69932f09dc12d7af26&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        DispatchQueue.main.async {
                            delegate?.updateViews(self, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
   
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.list[0].main.temp
            let id = decodedData.list[0].weather[0].id
            let name = decodedData.list[0].name
            
            let weather = WeatherModel(cityName: name, conditionID: id, temperature: temp)
            print(weather.conditionIconName)
            print(weather.temperatureString)
            return weather
        } catch {
            return nil
        }
    }
}
