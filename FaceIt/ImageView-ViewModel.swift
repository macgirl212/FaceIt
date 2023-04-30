//
//  SmallImageView-ViewModel.swift
//  FaceIt
//
//  Created by Melody Davis on 4/30/23.
//

import Foundation

extension ImageView {
    @MainActor class ViewModel: ObservableObject {
        func getImageData(_ person: Person) -> Data {
            let imageUrl = getDocumentsDirectory().appendingPathComponent(person.wrappedImageFile)
            
            let imageData = try? Data(contentsOf: imageUrl)
            
            return imageData ?? Data()
        }
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            return documentsDirectory
        }
    }
}
