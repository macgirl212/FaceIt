//
//  ImageView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/30/23.
//

import SwiftUI

struct ImageView: View {
    var person: Person
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        // might need to change the image sizes
        if !person.wrappedImageFile.isEmpty {
            Image(uiImage: UIImage(data: viewModel.getImageData(person)) ?? UIImage())
                .resizable()
                .scaledToFit()
        } else {
            Image("Unknown")
                .resizable()
                .scaledToFit()
        }
    }
}
