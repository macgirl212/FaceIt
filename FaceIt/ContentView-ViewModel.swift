//
//  ContentView-ViewModel.swift
//  FaceIt
//
//  Created by Melody Davis on 4/30/23.
//

import Foundation
import UIKit

extension ContentView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var showingAddPersonView: Bool = false
        @Published var pickedImage: UIImage?
        
        func deleteFile(_ person: Person) {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
                for fileURL in fileURLs where fileURL.absoluteString.contains(person.wrappedImageFile) {
                    try FileManager.default.removeItem(at: fileURL)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
