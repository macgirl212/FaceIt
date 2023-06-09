//
//  AddPersonView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/27/23.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = ViewModel()
    
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
            .navigationTitle("Add new person")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        let newPerson = Person(context: moc)
                        viewModel.addPerson(newPerson)
                        
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

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
