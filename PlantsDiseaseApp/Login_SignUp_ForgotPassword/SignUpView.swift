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
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Username")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    TextField("MohammadGhazal", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .textContentType(.emailAddress)
                }
                .padding(.top, 15)
                .padding()
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
                .padding()
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Password")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                    TextField("", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .textContentType(.password)
                }
                .padding()
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
                .padding()
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
