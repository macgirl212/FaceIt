//
//  EditPersonView.swift
//  FaceIt
//
//  Created by Melody Davis on 5/10/23.
//

import SwiftUI
import UIKit

struct EditPersonView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: ViewModel
    
    init(person: Person, pickedImage: UIImage?) {
        _viewModel = StateObject(wrappedValue: ViewModel(person: person, pickedImage: pickedImage))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                PersonSelectImageView(pickedImage: $viewModel.pickedImage, isShowingSourceMenu: $viewModel.isShowingSourceMenu)
                
                Spacer()
                
                PersonTextfieldsView(firstName: $viewModel.newFirstName, lastName: $viewModel.newLastName)
                
                Spacer()
                Spacer()
            }
            .background(
                colorScheme == .light
                        ? CustomColor.darkListBackground
                        : CustomColor.ultraDark
            )
            .navigationTitle("Edit person")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .automatic) {
                    Button("Update") {
                        let updatedPerson = Person(context: moc)
                        viewModel.updatePerson(updatedPerson)

                        let updatedImage = viewModel.convertToUIImage(updatedPerson.wrappedImageFile)

                        viewModel.pickedImage = updatedImage
                        
                        // need to fix image not refreshing...

                        try? moc.save()
                        
                        dismiss()
                    }
                    .disabled(!viewModel.isValidEntry)
                }
                
            }
            .onAppear {
                viewModel.locationFetcher.start()
            }
        }
        .accentColor(CustomColor.lightListBackground)
        .sheet(isPresented: $viewModel.isShowingPicker) {
            ImagePicker(image: $viewModel.pickedImage)
        }
        .confirmationDialog("How do you want to import a photo?", isPresented: $viewModel.isShowingSourceMenu) {
            Button("Take New Photo") { }
            Button("Import from Library") { viewModel.isShowingPicker = true }
            Button("Cancel", role: .cancel) { }
        }
        .accentColor(CustomColor.lightListBackground)
        .onAppear {
            viewModel.locationFetcher.start()
        }
    }
}

struct EditPersonView_Previews: PreviewProvider {
    static var previews: some View {
        EditPersonView(person: Person(), pickedImage: nil)
    }
}
