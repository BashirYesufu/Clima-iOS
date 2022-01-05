//
//  WeatherModel.swift
//  Clima
//
//  Created by mac on 1/4/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let conditionID: Int
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var conditionIconName: String {
        let icon: String
        switch conditionID {
        case ...299:
            icon = "cloud.bolt"
        case 300...399:
            icon = "cloud.drizzle"
        case 500...599:
            icon = "cloud.rain"
        case 600...699:
            icon = "cloud.snow"
        case 700...799:
            icon = "sun.dust"
        case 800:
            icon = "sun.min"
        case 801...899:
            icon = "cloud.fill"
        default:
            icon = "sun.max"
        }
        return icon
    }
    
}
