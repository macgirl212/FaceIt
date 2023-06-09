//
//  AddPersonView-ViewModel.swift
//  FaceIt
//
//  Created by Melody Davis on 4/30/23.
//

import Foundation
import UIKit

extension AddPersonView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var firstName: String = ""
        @Published var lastName: String = ""
        @Published var isShowingPicker: Bool = false
        @Published var isShowingSourceMenu: Bool = false
        @Published var pickedImage: UIImage?
        
        let locationFetcher = LocationFetcher()
        
        var isValidEntry: Bool {
            // checks if name has any word characters and if an image exists
            (firstName.contains(/\w/) || lastName.contains(/\w/)) && pickedImage != nil
        }
        
        func addPerson(_ person: Person) {
            person.id = UUID()
            person.firstName = firstName
            person.lastName = lastName
            
            if let location = self.locationFetcher.lastKnownLocation {
                person.latitude = location.latitude
                person.longitude = location.longitude
            } else {
                print("Your location is unknown")
            }
            
            let imageName = UUID().uuidString
            
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let imageFileName = path.appendingPathComponent(imageName)
            
            guard let uiImage = pickedImage else { return }
            
            if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                do {
                    try jpegData.write(to: imageFileName, options: [.atomic, .completeFileProtection])
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            
            person.imageFile = imageName
        }
    }
}
