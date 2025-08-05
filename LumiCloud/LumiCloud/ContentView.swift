//
//  ContentView.swift
//  LumiCloud
//
//  Created by Isam El Mourabet on 5/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Ver coordenadas") {
                Task {
                    let geocodingClient = GeocodingClient()
                    let weatherClient = WeatherClient()
                    
                    let location = try! await geocodingClient.coordinateByCity("Alicante")
                    let weather = try! await weatherClient.fetchWeather(location: location!)
                    
                    print(weather)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
