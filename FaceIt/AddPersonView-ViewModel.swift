//
//  AddPersonView-ViewModel.swift
//  FaceIt
//
//  Created by Melody Davis on 4/30/23.
//

import Foundation
import UIKit

extension AddPersonView {
    @MainActor class ViewModel: ObservableObject {
        @Published var name: String = ""
        @Published var isShowingPicker: Bool = false
        @Published var isShowingSourceMenu: Bool = false
        @Published var pickedImage: UIImage?
        
        let locationFetcher = LocationFetcher()
        
        var isValidEntry: Bool {
            // name textfield might need some extra validation
            !name.isEmpty && pickedImage != nil
        }
        
        func addPerson(_ person: Person) {
            person.id = UUID()
            person.name = name
            
            if let location = self.locationFetcher.lastKnownLocation {
                person.latitude = location.latitude
                person.longitude = location.longitude
            } else {
                print("Your location is unknown")
            }
            
            
            let imageName = UUID().uuidString
            let imageFileName = getDocumentsDirectory().appendingPathComponent(imageName)
            
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
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            return documentsDirectory
        }
    }
}
