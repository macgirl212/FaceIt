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
        @Published var isShowingEditView: Bool = false
        
        init(person: Person) {
            self.person = person
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude), span: MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025))
        }
        
        var annotations: [Person] {
            [person]
        }
        
        func sendUIImage(_ imageFile: String) -> UIImage? {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let imageUrl = path.appendingPathComponent(imageFile)
            
            let imageData = try? Data(contentsOf: imageUrl)
            
            return UIImage(data: imageData ?? Data())
        }
    }
}
