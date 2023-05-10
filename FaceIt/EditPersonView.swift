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
    
    init(firstName: String, lastName: String, pickedImage: UIImage?) {
        _viewModel = StateObject(wrappedValue: ViewModel(firstName: firstName, lastName: lastName, pickedImage: pickedImage))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                PersonSelectImageView(pickedImage: $viewModel.pickedImage, isShowingSourceMenu: $viewModel.isShowingSourceMenu)
                
                Spacer()
                
                PersonTextfieldsView(firstName: $viewModel.firstName, lastName: $viewModel.lastName)
                
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
                        // edit person function to come
                        
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
        EditPersonView(firstName: "", lastName: "", pickedImage: UIImage())
    }
}
