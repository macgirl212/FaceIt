//
//  FaceItApp.swift
//  FaceIt
//
//  Created by Melody Davis on 4/27/23.
//

import SwiftUI

@main
struct FaceItApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
