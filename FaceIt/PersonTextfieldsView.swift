//
//  PersonTextfieldsView.swift
//  FaceIt
//
//  Created by Melody Davis on 5/10/23.
//

import SwiftUI

struct PersonTextfieldsView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    
    var body: some View {
        VStack {
            TextField("First name", text: $firstName)
                .padding([.leading, .trailing])
                .font(.title2)
                .background(.bar)
                .padding([.leading, .trailing])
            
            TextField("Last name", text: $lastName)
                .padding([.leading, .trailing])
                .font(.title2)
                .background(.bar)
                .padding([.leading, .trailing])
        }
    }
}

struct PersonTextfieldsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonTextfieldsView(firstName: .constant(""), lastName: .constant(""))
    }
}
