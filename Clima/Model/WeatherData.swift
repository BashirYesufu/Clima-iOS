//
//  WeatherData.swift
//  Clima
//
//  Created by mac on 1/4/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable  {
    let list: [List]
}

struct List: Decodable {
    let main: Main
}

struct Main: Decodable {
    let temp: Double
}
