//
//  ImageView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/30/23.
//

import SwiftUI

struct ImageView: View {
    @StateObject private var viewModel: ViewModel
    
    init(person: Person) {
        _viewModel = StateObject(wrappedValue: ViewModel(person: person))
    }
    
    var body: some View {
        if !viewModel.person.wrappedImageFile.isEmpty {
            Image(uiImage: UIImage(data: viewModel.getImageData(viewModel.person)) ?? UIImage())
                .resizable()
                .scaledToFit()
        } else {
            Image("Unknown")
                .resizable()
                .scaledToFit()
        }
    }
}
