//
//  MapView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 10/7/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    
    //32.216105, 35.249491
    
    @State var landmarks: [Landmark] = [
        Landmark(name: "Sydney Harbour Bridge", location: .init(latitude: 32.216105, longitude: 35.249491)),
        Landmark(name: "Brooklyn Bridge", location: .init(latitude: 32.216105, longitude: 32.145665))]
    @State var selectedLandmark: Landmark? = nil
    @ObservedObject var networkingManager =  NetworkManager()
    @State var shouldShowIndicator = true
    
    var body: some View {
        Group {
            if shouldShowIndicator {ActivityIndicator(isAnimating: $shouldShowIndicator)}
            else {
                ZStack {
                    MapViewContainer(landmarks: $networkingManager.diseasesLocoation,
                                     selectedLandmark: $selectedLandmark)
                        .edgesIgnoringSafeArea(.vertical)
                }
            }
        }
        .onAppear() {
            self.networkingManager.getDiseasesLocation() { result in
                self.shouldShowIndicator = false
            }
        }
    }
    
    //    private func selectNextLandmark() {
    //        if let selectedLandmark = selectedLandmark, let currentIndex = landmarks.firstIndex(where: { $0 == selectedLandmark }), currentIndex + 1 < landmarks.endIndex {
    //            self.selectedLandmark = landmarks[currentIndex + 1]
    //        } else {
    //            selectedLandmark = landmarks.first
    //        }
    //    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


struct MapViewContainer: UIViewRepresentable {
    @Binding var landmarks: [Landmark]
    @Binding var selectedLandmark: Landmark?
    @EnvironmentObject var location: LocationManager
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        //   map.selectAnnotation(Landmark(name: "Current", location: .init(latitude: location.lastKnownLocation?.coordinate.latitude ?? 0.0, longitude: location.lastKnownLocation?.coordinate.longitude ?? 0.0)), animated: true)
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateAnnotations(from: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapViewContainer
        
        init(_ control: MapViewContainer) {
            self.control = control
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let coordinates = view.annotation?.coordinate else { return }
            let span = mapView.region.span
            let region = MKCoordinateRegion(center: coordinates, span: span)
            mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? LandmarkAnnotation else { return nil }
            let identifier = "Annotation"
            var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let newAnnotations = landmarks.map { LandmarkAnnotation(landmark: $0) }
        mapView.addAnnotations(newAnnotations)
        //        if let selectedAnnotation = newAnnotations.filter({ $0.id == selectedLandmark?.id }).first {
        //            mapView.selectAnnotation(selectedAnnotation, animated: true)
        //        }
    }
}
