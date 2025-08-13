//
//  Location.swift
//  LumiCloud
//
//  Created by Isam El Mourabet on 5/8/25.
//

import Foundation

struct Location: Decodable, Identifiable {
    var id = UUID()
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}
