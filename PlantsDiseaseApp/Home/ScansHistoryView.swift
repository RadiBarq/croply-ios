//
//  ScansHistoryView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/28/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI
struct ScansHistoryView: View {

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var shouldShowAlert = false
    @ObservedObject var networkingManager =  NetworkManager(endpoint: "plant/get_all_scans_mobile", user: SessionManager.user!)
    //    @State var scans = [
    //        Scan(id: 0 , userId: 0, diseaseName: "Apple Scab", cropName: "Apple", thumbnail: "apple_scab_test", createdAt: "September 28, 2019", lat: 32.234562, lng: 35.251255),
    //        Scan(id: 1, userId: 1, diseaseName: "Apple Scab", cropName: "Apple", thumbnail: "apple_scab_test", createdAt: "September 28, 2019", lat: 32.234562, lng: 35.251255),
    //        Scan(id: 2, userId: 2, diseaseName: "Apple Scab", cropName: "Apple", thumbnail: "apple_scab_test", createdAt: "September 28, 2019", lat: 32.234562, lng: 35.251255),
    //        Scan(id: 3, userId: 3, diseaseName: "Apple Scab", cropName: "Apple", thumbnail: "apple_scab_test", createdAt: "September 28, 2019", lat: 32.234562, lng: 35.251255),
    //        Scan(id: 4, userId: 4, diseaseName: "Apple Scab", cropName: "Apple", thumbnail: "apple_scab_test", createdAt: "September 28, 2019" , lat: 32.234562, lng: 35.251255)
    //    ]
     
    func test() {
        
        
    }
    
    var body: some View {
        networkingManager.getScansHistory(for: SessionManager.user!) { result in
        }
        return NavigationView {
            List(networkingManager.scansHistory) { scan in
                NavigationLink(destination: EmptyView()) {
                    HistoryCell(imageURL: "apple_scab_test", diseaseName: scan.diseaseName, cropName: scan.cropName, createdAt: scan.createdAt)
                }
            }
            .navigationBarTitle("History")
        }
        .colorScheme(.dark)
        .alert(isPresented: $shouldShowAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
       }
    }
}

fileprivate struct HistoryCell: View {
    let imageURL: String?
    let diseaseName: String?
    let cropName: String?
    let createdAt: String?
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Image(imageURL ?? " ")
                    .resizable()
                    .frame(width: 180, height: 220)
                    .cornerRadius(5)
                    .padding(.top, 15)
            }
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(diseaseName ?? " ")
                        .fontWeight(.bold)
                        .font(.title)
                        .lineLimit(3)
                        .padding()
                }
                HStack {
                    Text(cropName ?? " ")
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.leading, 15)
                }
                Spacer()
                HStack(alignment: .top) {
                    Text(createdAt ?? " ")
                        .foregroundColor(.white)
                        .font(.footnote)
                        .padding(.leading, 15)
                }
            }
        }
        .padding(.bottom, 15)
    }
}

struct ScansHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ScansHistoryView()
    }
}
