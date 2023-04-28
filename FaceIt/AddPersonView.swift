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
    
    @State private var name: String = ""
    @State private var isShowingPicker: Bool = false
    @State private var pickedImage: UIImage?
    
    var isValidEntry: Bool {
        // name textfield might need some extra validation
        !name.isEmpty && pickedImage != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Add name", text: $name)
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
                        let newPerson = Person(context: moc)
                        newPerson.id = UUID()
                        newPerson.name = name
                        
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
                        
                        newPerson.imageFile = imageName
                        
                        dismiss()
                    }
                    .disabled(!isValidEntry)
                }
                
            }
        }
        .sheet(isPresented: $isShowingPicker) {
            ImagePicker(image: $pickedImage)
        }
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
