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
            if person.imageFile != nil {
                let imageUrl = getDocumentsDirectory().appendingPathComponent(person.imageFile ?? "")
                
                let imageData = try? Data(contentsOf: imageUrl)
                Image(uiImage: UIImage(data: imageData ?? Data()) ?? UIImage())
                    .resizable()
                    .scaledToFit()
            } else {
                Image("Unknown")
                    .resizable()
                    .scaledToFit()
            }
            
            Text(person.name ?? "Unknown")
                .font(.largeTitle)
                .padding()
            
            Spacer()
        }
    }
}
