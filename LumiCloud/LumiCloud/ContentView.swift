//
//  ContentView.swift
//  LumiCloud
//
//  Created by Isam El Mourabet on 5/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var city: String = ""
    @State private var city2: String = ""
    @State private var isFectchingWeather: Bool = false

    let geocodingClient = GeocodingClient()
    let weatherClient = WeatherClient()
    let weatherInformationClient = WeatherInformationClient()
    
    @State private var weather: Weather?
    @State private var information: [Information?] = []
    
    private func fetchWeather() async {
        do {
            guard let location = try await geocodingClient.coordinateByCity(city) else { return }
            weather = try await weatherClient.fetchWeather(location: location)
            information = try await weatherInformationClient.fetchWeatherInformation(location: location)
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
                                city2 = city
                                city = ""
                            }
                        }
                    
                    Spacer()
                    
                    if let info = information.first {
                        Text(info!.description.localizedWeatherDescription(for: Locale(identifier: "es")))
                            .padding()
                    }
                                        
                    if let weather {
                        VStack {
                            Text("Sensación térmica: " + MeasurementFormatter.temperature(value: weather.feels_like))
                                .padding(10)
                                .font(.caption)
                            
                            Spacer()
                            
                            VStack {
                                Text(city2)
                                Text(MeasurementFormatter.temperature(value: weather.temp))
                                    .font(.system(size: 64))
                            }
                            
                            HStack {
                                GlassEffectContainer {
                                    VStack {
                                        Text("Min")
                                            .font(.caption2)
                                            .padding(5)
                                            .offset(y: 10)
                                        
                                        Text(MeasurementFormatter.temperature(value: weather.temp_min))
                                            .padding(10)
                                            .glassEffect()
                                    }
                                    .font(.title3)
                                    .padding(10)
                                }
                                
                                Spacer()
                                
                                GlassEffectContainer {
                                    VStack {
                                        Text("Max")
                                            .font(.caption2)
                                            .padding(5)
                                            .offset(y: 10)
                                        
                                        Text(MeasurementFormatter.temperature(value: weather.temp_max))
                                            .padding(10)
                                            .glassEffect()
                                        
                                    }
                                    .font(.title3)
                                    .padding(10)
                                }
                            }
                        }
                        .frame(width: 225, height: 275)
                        .background(Color(.systemFill))
                        .cornerRadius(25)
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
