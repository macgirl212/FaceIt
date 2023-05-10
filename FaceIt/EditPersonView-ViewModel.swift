//
//  EditPersonView-ViewModel.swift
//  FaceIt
//
//  Created by Melody Davis on 5/10/23.
//

import Foundation
import UIKit

extension EditPersonView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var firstName: String
        @Published var lastName: String
        @Published var isShowingPicker: Bool = false
        @Published var isShowingSourceMenu: Bool = false
        @Published var pickedImage: UIImage?
        
        init(firstName: String, lastName: String, pickedImage: UIImage?) {
            self.firstName = firstName
            self.lastName = lastName
            self.pickedImage = pickedImage
        }
        
        let locationFetcher = LocationFetcher()
        
        var isValidEntry: Bool {
            // checks if name has any word characters and if an image exists
            firstName.contains(/\w/) || lastName.contains(/\w/)
        }
    }
}
