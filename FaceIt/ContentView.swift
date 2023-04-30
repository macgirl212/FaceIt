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
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(people) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        HStack {
                            ImageView(person: person)
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                            
                            Text(person.wrappedName)
                                .font(.title)
                        }
                    }
                }
            }
            .navigationTitle("Face It")
            .toolbar {
                Button {
                    viewModel.showingAddPersonView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingAddPersonView) {
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
