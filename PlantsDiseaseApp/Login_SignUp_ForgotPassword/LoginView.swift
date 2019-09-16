//
//  LoginView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/10/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
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
                Section(header: Text("Email")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.top, 15),
                    footer:
                    TextField("radibaraq@gmail.com", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .textContentType(.emailAddress)
                ) {
                    EmptyView()
                }
                .font(.headline)
                Section(
                    header:
                        Text("Password")
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.top, 15)
                    ,
                    footer: SecureField("", text: $password)
                        .padding()
                        .cornerRadius(5)
                        .background(Color.white)
                        .textContentType(.password)) {
                            
                            EmptyView()
                }
                .cornerRadius(5)
                .font(.headline)
                Section(footer:
                    HStack {
                        Spacer()
                        Button(action: {
                            self.loginClicked()
                        }) {
                            Text("Log in")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            
                        }
                        .frame(width: 150,alignment: .center)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        Spacer()
                    }
                    .font(.headline)
                ){
                    EmptyView()
                }
                Section(footer:
                    HStack {
                        Spacer()
                        Button(action: {
                            self.signupClicked()
                        }) {
                            Text("Forgot password?")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                ){
                    EmptyView()
                }
                .font(.headline)
                Section(footer:
                HStack {
                    Spacer()
                    Text("Don't have an account?")
                        .foregroundColor(.green)
                        .font(.subheadline)
                    Button(action: {
                        self.signupClicked()
                    }) {
                        Text("Sign up here")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    Spacer()
                }){
                     EmptyView()
                }
            }
            .colorScheme(.dark)
            .cornerRadius(15)
            .frame(height: 440)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
