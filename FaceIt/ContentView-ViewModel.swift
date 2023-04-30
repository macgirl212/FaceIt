//
//  ContentView-ViewModel.swift
//  FaceIt
//
//  Created by Melody Davis on 4/30/23.
//

import Foundation
import UIKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var showingAddPersonView: Bool = false
        @Published var pickedImage: UIImage?
    }
}
