//
//  ContentView.swift
//  LumiCloud
//
//  Created by Isam El Mourabet on 5/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var city: String = ""
    @State private var isFectchingWeather: Bool = false

    let geocodingClient = GeocodingClient()
    let weatherClient = WeatherClient()
    let weatherInformationClient = WeatherInformationClient()
    
    @State private var weather: Weather?
    @State private var information: [Information?] = []
    @State private var location: Location?
    
    private func fetchWeather() async {
        do {
            //guard let location = try await geocodingClient.coordinateByCity(city) else { return }
            location = try await geocodingClient.coordinateByCity(city)
            weather = try await weatherClient.fetchWeather(location: location!)
            information = try await weatherInformationClient.fetchWeatherInformation(location: location!)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.cyan.opacity(0.5)
                    .ignoresSafeArea(.all)
                
                VStack {
                    TextField("Introduce una ciudad", text: $city)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            isFectchingWeather = true
                        } .task(id: isFectchingWeather) {
                            if isFectchingWeather {
                                await fetchWeather()
                                isFectchingWeather = false
                                city = ""
                            }
                        }
                    
                    Spacer()
                    
                    if let info = information.first {
                        Text(info!.description.localizedWeatherDescription(for: Locale(identifier: "es")))
                            .padding()
                    }
                                        
                    if let weather {
                        WeatherCardView(weather: weather, location: location)
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Temperatura")
            }
        }
    }
}

#Preview {
    ContentView()
}
