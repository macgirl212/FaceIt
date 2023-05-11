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
        @Published var person: Person
        @Published var newFirstName: String
        @Published var newLastName: String
        @Published var isShowingPicker: Bool = false
        @Published var isShowingSourceMenu: Bool = false
        @Published var pickedImage: UIImage?
        
        init(person: Person, pickedImage: UIImage?) {
            self.person = person
            self.newFirstName = person.wrappedFirstName
            self.newLastName = person.wrappedLastName
            self.pickedImage = pickedImage
        }
        
        let locationFetcher = LocationFetcher()
        
        var isValidEntry: Bool {
            // checks if name has any word characters and if an image exists
            newFirstName.contains(/\w/) || newLastName.contains(/\w/)
        }
        
        func updatePerson(_ person: Person) {
            person.id = self.person.id
            person.firstName = newFirstName
            person.lastName = newLastName
            
            if let location = self.locationFetcher.lastKnownLocation {
                person.latitude = location.latitude
                person.longitude = location.longitude
            } else {
                print("Your location is unknown")
            }
            
            deleteFile(self.person.wrappedImageFile)
            
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
 
            self.person = person
        }
        
        func deleteFile(_ imageFile: String) {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
                for fileURL in fileURLs where fileURL.absoluteString.contains(imageFile) {
                    try FileManager.default.removeItem(at: fileURL)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func convertToUIImage(_ imageFile: String) -> UIImage? {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let imageUrl = path.appendingPathComponent(imageFile)
            
            let imageData = try? Data(contentsOf: imageUrl)
            
            return UIImage(data: imageData ?? Data())
        }
    }
}
