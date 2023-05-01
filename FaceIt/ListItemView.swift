//
//  ListItemView.swift
//  FaceIt
//
//  Created by Melody Davis on 5/1/23.
//

import SwiftUI

struct ListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    var person: Person
    
    var body: some View {
        HStack {
            ImageView(person: person)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            colorScheme == .light
                                ? CustomColor.darkListBackground
                                : CustomColor.ultraDark,
                                lineWidth: 4
                        )
                )
                .frame(width: 100, height: 100)
                
            
            Text(person.wrappedName)
                .font(.title)
        }
    }
}
