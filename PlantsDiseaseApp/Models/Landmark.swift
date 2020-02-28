//
//  Landmark.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 10/7/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation
import MapKit

struct Landmark {
    let id = UUID().uuidString
    let name: String
    let location: CLLocationCoordinate2D
    let red: Int
    let green: Int
    let blue: Int
    
    static func ==(lhs: Landmark, rhs: Landmark) -> Bool {
        lhs.id == rhs.id
    }
}

final class LandmarkAnnotation: NSObject, MKAnnotation {
    let id: String
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let red: Int
    let green: Int
    let blue: Int
    
    init(landmark: Landmark) {
        self.id = landmark.id
        self.title = landmark.name
        self.coordinate = landmark.location
        self.red = landmark.red
        self.green = landmark.green
        self.blue = landmark.blue
    }
}


