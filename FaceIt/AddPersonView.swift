//
//  AddPersonView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/27/23.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Add name", text: $viewModel.name)
                }
                
                Section {
                    Button {
                        viewModel.isShowingPicker = true
                    } label: {
                        Text("Add image")
                    }
                    
                    if viewModel.pickedImage != nil {
                        Image(uiImage: viewModel.pickedImage!)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
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
                        
                        dismiss()
                    }
                    .disabled(!viewModel.isValidEntry)
                }
                
            }
        }
        .sheet(isPresented: $viewModel.isShowingPicker) {
            ImagePicker(image: $viewModel.pickedImage)
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
