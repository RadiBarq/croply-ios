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
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var shouldShowAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showIndicator = false
    
    @EnvironmentObject var user: SessionUser
    @State private var myFormatter = LengthFormatter()
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    Image("grapes")
                        .resizable()
                        .frame(width: 75, height: 130, alignment: .center)
                }
                Form {
                    Section(header:
                        Text("Username").foregroundColor(.green)
                            .font(.headline)
                            .padding(.top, 15)
                        ,
                            footer:
                        TextField("MohammadGhazal", text: $userName)
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
                        SecureField("", text: $password)
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
                                VStack {
                                    if !showIndicator {
                                        Text("Sign up")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                    }
                                    else{
                                        ActivityIndicator(isAnimating: $showIndicator)
                                    }
                                }
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
                            }
                            Spacer()
                        }
                    ){
                        EmptyView()
                    }
                    .font(.subheadline)
                }
                .cornerRadius(15)
                .frame(height: 500)
                .padding()
                Spacer()
            }
            .padding(.top, 15)
        }
        .padding(.top, 20)
        .background(
            Image("choice")
                .resizable()
                .aspectRatio(contentMode: .fill))
            .edgesIgnoringSafeArea([.top])
            .alert(isPresented: $shouldShowAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    func loginClicked() {
        self.user.signedUpClicked = false
        self.user.signedInClicked = true
    }
    func signupClicked() {
        
        if !email.isValidEmail() {
            alertTitle = "Invalid email address"
            alertMessage = "Make sure you entered a valid email address."
            shouldShowAlert = true
            return
        } else if password.count < 5 {
            alertTitle = "Passowrd is too short!"
            alertMessage = "Try again with a longer password."
            shouldShowAlert = true
            return
        } else if userName.count < 3 {
            alertTitle = "Username is too short"
            alertMessage = "Try again with longer username."
            shouldShowAlert = true
            return
        }
        let currentUser = User(id: 0, username: userName, email: email, password: password)
        let postRequest = APIRequest(endpoint: "auth/register_mobile")
        showIndicator = true
        postRequest.signUpUser(user: currentUser, completion: { result in
            self.showIndicator = false
            switch result {
            case .success(let response):
                switch response.result {
                case "success":
                    DispatchQueue.main.async {
                        guard let user = response.user else { return }
                        SessionManager.user = user
                        self.user.email = user.email
                        self.user.username = user.username
                        self.user.id = user.id
                        self.user.signedUpClicked = false
                        self.user.signedInClicked = false
                        UserDefaults.standard.set(self.user.email , forKey: "email")
                        UserDefaults.standard.set(self.user.id , forKey: "id")
                        UserDefaults.standard.set(self.user.username , forKey: "username")
                        UserDefaults.standard.set(true , forKey: "signed_in")
                    }
                case "email_error":
                    self.alertTitle = "This email address already signed up"
                    self.alertMessage = "Please try to sign in with this email."
                    self.shouldShowAlert = true
                default:
                    self.alertTitle = "Unexpected problem happened!"
                    self.alertMessage = "We are working on the issue."
                    self.shouldShowAlert = true
                }
            case .failure(let type):
                switch type {
                case .responseProblem:
                    self.alertTitle = "Connection problem happened!"
                    self.alertMessage = "Please try again later."
                    self.shouldShowAlert = true
                case .decondingProblem, .encodingProblem:
                    self.alertTitle = "Unexpected problem happened!"
                    self.alertMessage = "We are working on the issue."
                    self.shouldShowAlert = true
                }
            }
        })
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView()
        return v
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionUser())
    }
}
