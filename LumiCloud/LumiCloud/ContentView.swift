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
    
    @State private var weather: Weather?
    
    private func fetchWeather() async {
        do {
            guard let location = try await geocodingClient.coordinateByCity(city) else { return }
            weather = try await weatherClient.fetchWeather(location: location)
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
                    
                    if let weather {
                        Text(MeasurementFormatter.temperature(value: weather.temp))
                            .font(.system(size: 64))
                            .padding()
                        
                        HStack {
                            VStack {
                                Text("Min")
                                Text(MeasurementFormatter.temperature(value: weather.temp_min))
                            }
                            .font(.title2)
                            .padding(10)
                            .glassEffect(.regular .interactive() .tint(.blue))
                            
                            VStack {
                                Text("Max")
                                Text(MeasurementFormatter.temperature(value: weather.temp_max))
                            }
                            .font(.title2)
                            .padding(10)
                            .glassEffect(.regular .interactive() .tint(.red))
                        }
                        
                        
                        Text("Sensación térmica: " + MeasurementFormatter.temperature(value: weather.feels_like))
                            .padding()
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
