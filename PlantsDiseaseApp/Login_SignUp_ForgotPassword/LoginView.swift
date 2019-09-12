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
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Email")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    
                    TextField("radibaraq@gmail.com", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .textContentType(.emailAddress)
                }
                .padding(.top, 15)
                .padding()
                VStack(alignment: .leading, spacing: 15) {
                    Text("Password")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                    SecureField("", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .textContentType(.password)
                }
                .padding()
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
                .padding()
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
                .padding()
                HStack {
                    Spacer()
                    Text("Don't have an account?")
                        .foregroundColor(.green)
                    Button(action: {
                        self.signupClicked()
                    }) {
                        Text("Sign up here")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()
                    
                .padding(.bottom, 15)
            }
            .background(Color.black)
            .cornerRadius(20)
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
