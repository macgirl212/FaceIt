//
//  ContentView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/27/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var people: FetchedResults<Person>

    @State private var showingAddPersonView: Bool = false
    @State private var pickedImage: UIImage?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(people, id: \.id) { person in
                    HStack {
                        // might need to change the image sizes
                        if person.imageFile != nil {
                            let imageUrl = getDocumentsDirectory().appendingPathComponent(person.imageFile ?? "")

                            let imageData = try? Data(contentsOf: imageUrl)
                            Image(uiImage: UIImage(data: imageData ?? Data()) ?? UIImage())
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        } else {
                            Image("Unknown")
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                
                        }
                        
                        Text(person.name ?? "Unknown")
                            .font(.title)
                    }
                }
            }
            .navigationTitle("Face It")
            .toolbar {
                Button {
                    showingAddPersonView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddPersonView) {
                AddPersonView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
