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
                        // picture to come
                        
                        Text(person.name ?? "Unknown")
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
