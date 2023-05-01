//
//  PersonDetailView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/29/23.
//

import SwiftUI

struct PersonDetailView: View {
    var person: Person
    
    var body: some View {
        VStack {
            ImageView(person: person)
            
            Text(person.wrappedName)
                .font(.largeTitle)
                .padding()
            
            Spacer()
        }
        .background(CustomColor.background)
    }
}
