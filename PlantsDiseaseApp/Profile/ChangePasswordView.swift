//
//  ChangePasswordView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/12/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @State var oldPassword = ""
    @State var newPassword = ""
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Old password")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                    SecureField("", text: $oldPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                }
                .padding()
                .padding(.top, 15)
                VStack(alignment: .leading, spacing: 15) {
                    Text("New password")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                    SecureField("", text: $oldPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.changePasswordClicked()
                    }) {
                        Text("Change password")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                                .font(.headline)
                                
                    }
                    .frame(width: 150,alignment: .center)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    Spacer()
                }
                .padding()
                .padding(.bottom, 15)
            }
            .background(Color.black)
            .cornerRadius(20)
            .padding(.top, 100)
            .padding()
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarItems(leading:
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.black)
        })
    }
    
    func changePasswordClicked() {
        
        
        
        
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
