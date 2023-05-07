//
//  PersonDetailView-ViewModel.swift
//  FaceIt
//
//  Created by Melody Davis on 5/7/23.
//

import Foundation
import MapKit

extension PersonDetailView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var person: Person
        @Published var region: MKCoordinateRegion
        
        init(person: Person) {
            self.person = person
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
        
        var annotations: [Person] {
            [person]
        }
    }
}
