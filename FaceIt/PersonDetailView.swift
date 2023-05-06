//
//  PersonDetailView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/29/23.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    var person: Person
    @State private var region: MKCoordinateRegion
    
    init(person: Person) {
        self.person = person
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }
    
    var annotations: [Person] {
        [person]
    }
    
    var body: some View {
        VStack {
            ImageView(person: person)
            
            Text(person.wrappedName)
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            Map(coordinateRegion: $region, annotationItems: annotations) {
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude))
            }
            .padding()
        }
        .background(CustomColor.background)
    }
}
