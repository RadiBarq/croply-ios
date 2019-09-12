//
//  ChangeEmail.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/12/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @State private var email: String = "radibarq@gmail.com"
     @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Email")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        TextField(email, text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .textContentType(.emailAddress)
                    }
                    .padding()
                    .padding(.top, 15)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.changeEmailClicked()
                        }) {
                            Text("Change email")
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
        
    }
    
    func changeEmailClicked() {
        
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}
