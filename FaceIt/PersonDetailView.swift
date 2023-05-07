//
//  PersonDetailView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/29/23.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    @StateObject private var viewModel: ViewModel
    
    init(person: Person) {
        _viewModel = StateObject(wrappedValue: ViewModel(person: person))
    }
    
    var body: some View {
        VStack {
            ImageView(person: viewModel.person)
            
            Text(viewModel.person.wrappedName)
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.annotations) {
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude))
            }
            .padding()
        }
        .background(CustomColor.background)
    }
}
