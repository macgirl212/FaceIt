//
//  ContentView.swift
//  FaceIt
//
//  Created by Melody Davis on 4/27/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
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
                        ListItemView(person: person)
                    }
                    .listRowBackground(
                        colorScheme == .light
                            ? CustomColor.lightListBackground
                            : CustomColor.darkListBackground
                    )
                }
                .onDelete(perform: deletePerson)
            }
            .scrollContentBackground(.hidden)
            .background(CustomColor.background)
            .navigationTitle("Face It")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    viewModel.showingAddPersonView = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(
                            colorScheme == .light
                                ? CustomColor.darkListBackground
                                : CustomColor.lightListBackground
                        )
                }
            }
            .sheet(isPresented: $viewModel.showingAddPersonView) {
                AddPersonView()
            }
        }
    }

    func deletePerson(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            viewModel.deleteFile(person)
            moc.delete(person)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
