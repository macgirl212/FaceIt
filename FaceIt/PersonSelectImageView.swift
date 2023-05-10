//
//  PersonSelectImageView.swift
//  FaceIt
//
//  Created by Melody Davis on 5/10/23.
//

import SwiftUI
import UIKit

struct PersonSelectImageView: View {
    @Binding var pickedImage: UIImage?
    @Binding var isShowingSourceMenu: Bool
    
    var body: some View {
        VStack {
            if pickedImage != nil {
                Image(uiImage: pickedImage!)
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
                isShowingSourceMenu = true
            } label: {
                Text("Add Image")
                    .foregroundColor(CustomColor.lightListBackground)
            }
        }
    }
}

struct PersonSelectImageView_Previews: PreviewProvider {
    static var previews: some View {
        PersonSelectImageView(pickedImage: .constant(nil), isShowingSourceMenu: .constant(false))
    }
}
