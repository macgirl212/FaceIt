//
//  AddPersonView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/27/23.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var newName: String = ""
    @State private var isShowingPicker: Bool = false
    @State private var pickedImage: UIImage?
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Add name", text: $newName)
                }
                
                Section {
                    Button {
                        isShowingPicker = true
                    } label: {
                        Text("Add image")
                    }
                    
                    if pickedImage != nil {
                        Image(uiImage: pickedImage!)
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
                        dismiss()
                    }
                    .disabled(newName == "")
                }
                
            }
        }
        .sheet(isPresented: $isShowingPicker) {
            ImagePicker(image: $pickedImage)
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
