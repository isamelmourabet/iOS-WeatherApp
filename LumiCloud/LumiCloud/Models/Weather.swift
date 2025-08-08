//
//  Weather.swift
//  LumiCloud
//
//  Created by Isam El Mourabet on 5/8/25.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
    let weather: [Information]
}

struct Weather: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct Information: Decodable {
    let main: String
    let description: String
}
