//
//  WeatherInformationClient.swift
//  LumiCloud
//
//  Created by Isam El Mourabet on 7/8/25.
//

import Foundation

struct WeatherInformationClient {
    func fetchWeatherInformation(location: Location) async throws -> [Information] {
        let(data, response) = try await URLSession.shared.data(from: APIEndpoint.endpointURL(for: .weatherByLatLon(location.lat, location.lon)))
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let weatherInformationResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return weatherInformationResponse.weather
    }
}
