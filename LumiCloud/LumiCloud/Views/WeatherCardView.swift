//
//  WeatherCardView.swift
//  LumiCloud
//
//  Created by Isam El Mourabet on 14/8/25.
//

import SwiftUI

struct WeatherCardView: View {
    
    @State var weather: Weather
    @State var location: Location?
    
    var body: some View {
        VStack {
            Text("Sensación térmica: " + MeasurementFormatter.temperature(value: weather.feels_like))
                .padding(10)
                .font(.caption)
            
            Spacer()
            
            VStack {
                Text(location?.name ?? "Error")
                    .font(.title)
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
}
