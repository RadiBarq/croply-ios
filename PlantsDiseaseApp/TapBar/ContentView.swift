//
//  ContentView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/10/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    @State private var shouldPresentSheet = true
    @State private var selectedItem = "email"
    @EnvironmentObject var user: SessionUser
    @EnvironmentObject var location: LocationManager
    
    var body: some View {
        TabView(selection: $selection){
            if (!user.signedInClicked && !user.signedUpClicked ) {
                HomeView()
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                                .font(Font.title.weight(.semibold))
                        }
                }
                .tag(0)
            }
            else if user.signedInClicked  {
                LoginView()
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                                .font(Font.title.weight(.semibold))
                        }
                }
                .tag(0)
            }
                
            else {
                SignUpView()
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                                .font(Font.title.weight(.semibold))
                        }
                }
                .tag(0)
            }
            CameraView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                            .font(Font.largeTitle.weight(.semibold))
                    }
            }
            .tag(1)
            MapView()
                //  Text(self.location.latString)
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "map.fill")
                            .font(Font.largeTitle.weight(.semibold))
                    }
            }
            .tag(2)
            if (user.id != -1) {
                ProfileView().environmentObject(user)
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "person.fill")
                                .font(Font.largeTitle.weight(.semibold))
                                .foregroundColor(.red)
                        }
                }
                .tag(3)
            }
        }       .onAppear() {
                 let isSignedIn  = UserDefaults.standard.bool(forKey: "signed_in")
                 if isSignedIn {
                     let id  = UserDefaults.standard.integer(forKey: "id")
                     let username = UserDefaults.standard.string(forKey: "username")
                     let email = UserDefaults.standard.string(forKey: "email")
                     let sessionManagerUser = User(id: id, username: username!, email: email!, password: nil)
                     SessionManager.user = sessionManagerUser
                     self.user.signedInClicked = false
                     self.user.signedUpClicked = false
                     self.user.id = id
                     self.user.username = username!
                     self.user.email = email!
                 } else {
                     self.user.signedInClicked = true
                     self.user.signedUpClicked = false
                     self.user.id = -1
                     self.user.username = ""
                     self.user.email = ""
                 }
            }
                .accentColor(.green)
                .edgesIgnoringSafeArea([.top])
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environmentObject(SessionUser())
        }
}
