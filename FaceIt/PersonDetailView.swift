//
//  PersonDetailView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/29/23.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel: ViewModel
    
    init(person: Person) {
        _viewModel = StateObject(wrappedValue: ViewModel(person: person))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageView(person: viewModel.person)
                
                Text("\(viewModel.person.wrappedFirstName) \(viewModel.person.wrappedLastName)")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        Text("Full Screen Map")
                    } label: {
                        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.annotations) {
                            MapMarker(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude))
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(CustomColor.ultraDark, lineWidth: 2)
                        )
                    }
                }
                .padding([.leading, .trailing])
            }
            .background(CustomColor.background)
        }
    }
}
