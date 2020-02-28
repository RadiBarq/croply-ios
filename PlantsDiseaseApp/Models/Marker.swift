//
//  Marker.swift
//  PlantsDiseaseApp
//
//  Created by Harri on 11/26/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation

class Marker: Codable {
    let count: Int
    let lat: Double
    let lng: Double
    let disease: Disease
    let red: Int
    let green: Int
    let blue: Int
}
