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
                if viewModel.pickedImage != nil {
                    Image(uiImage: viewModel.pickedImage!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                } else {
                    Image("Unknown")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                
                Button {
                    viewModel.isShowingSourceMenu = true
                } label: {
                    Text("Add Image")
                        .foregroundColor(CustomColor.lightListBackground)
                }
                
                Spacer()
                
                TextField("First name", text: $viewModel.firstName)
                    .padding([.leading, .trailing])
                    .font(.title2)
                    .background(.bar)
                    .padding([.leading, .trailing])
                
                TextField("Last name", text: $viewModel.lastName)
                    .padding([.leading, .trailing])
                    .font(.title2)
                    .background(.bar)
                    .padding([.leading, .trailing])
                
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
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
