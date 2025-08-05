//
//  Weather.swift
//  LumiCloud
//
//  Created by Isam El Mourabet on 5/8/25.
//

import Foundation

struct Weather: Encodable {
    let main: Temperature
    let weather: WeatherInformation
}

struct Temperature: Encodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct WeatherInformation: Encodable {
    let main: String
    let description: String
}
