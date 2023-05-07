//
//  SmallImageView-ViewModel.swift
//  FaceIt
//
//  Created by Melody Davis on 4/30/23.
//

import Foundation

extension ImageView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var person: Person
        
        init(person: Person) {
            self.person = person
        }
        
        func getImageData(_ person: Person) -> Data {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let imageUrl = path.appendingPathComponent(person.wrappedImageFile)
            
            let imageData = try? Data(contentsOf: imageUrl)
            
            return imageData ?? Data()
        }
    }
}
