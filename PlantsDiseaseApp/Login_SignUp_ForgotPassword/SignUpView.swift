//
//  SignUpView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/11/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Image("grapes")
                    .resizable()
                    .frame(width: 75, height: 130, alignment: .center)
                }
            Form {
                Section(header:
                    Text("Username")                        .foregroundColor(.green)
                        .font(.headline)
                        .padding(.top, 15)
                    ,
                    footer:
                    TextField("MohammadGhazal", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .font(.headline)
                        .textContentType(.username)
                ){
                    EmptyView()
                }
            
                Section(
                    header:
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding(.top, 15)
                    ,
                    footer:
                        TextField("radibaraq@gmail.com", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .font(.headline)
                            .textContentType(.emailAddress)
                    ){
                        EmptyView()
                    }
                

                Section (
                    header:
                        Text("Password")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding(.top, 15),
                    footer:
                        TextField("", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .textContentType(.password)
                    ){
                        EmptyView()
                    }
                Section(footer:
                    HStack {
                    Spacer()
                    Button(action: {
                        self.signupClicked()
                    }) {
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 150,alignment: .center)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    Spacer()
                    }
                ){
                    EmptyView()
                }
                .font(.headline)
                
                Section(footer:
                HStack {
                    Spacer()
                    Text("Have an account?")
                        .foregroundColor(.green)
                    Button(action: {
                        self.loginClicked()
                    }) {
                        Text("Sign in here")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                ){
                   EmptyView()
                }
                .font(.subheadline)
            }
            .colorScheme(.dark)
            .cornerRadius(15)
            .frame(height: 500)
            .padding()
            Spacer()
        }
        .background(
            Image("choice")
                .resizable()
                .aspectRatio(contentMode: .fill))
            .edgesIgnoringSafeArea([.top, .bottom])
    }
    
    func loginClicked() {
        
    }
    
    func signupClicked() {
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
