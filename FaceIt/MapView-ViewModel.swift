//
//  MapView-ViewModel.swift
//  FaceIt
//
//  Created by Melody Davis on 5/9/23.
//

import MapKit
import Foundation

extension MapView {
    @MainActor class ViewModel: ObservableObject {
        @Published var person: Person
        @Published var region: MKCoordinateRegion
        
        init(person: Person) {
            self.person = person
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
        }
    }
}
