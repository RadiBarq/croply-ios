//
//  LoctionManager.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 10/7/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager: CLLocationManager
    @Published var lastKnownLocation: CLLocation?
    @Published var latString: String = ""
    @Published var longString: String = ""
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
        self.startUpdating()
    }
    
    func startUpdating() {
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         print(locations)
         lastKnownLocation = locations.last
         latString = String(format: "%f", lastKnownLocation?.coordinate.latitude ?? 0.0)
         longString = String(format: "%f", lastKnownLocation?.coordinate.latitude ?? 0.0)
         self.manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
