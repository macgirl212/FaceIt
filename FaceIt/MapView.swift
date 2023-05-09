//
//  MapView.swift
//  FaceIt
//
//  Created by Melody Davis on 5/9/23.
//

import MapKit
import SwiftUI

struct MapView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var people: FetchedResults<Person>
    
    @StateObject var viewModel: ViewModel
    
    init(person: Person) {
        _viewModel = StateObject(wrappedValue: ViewModel(person: person))
    }
    
    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $viewModel.region, annotationItems: people) { location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            }
        }
    }
}
