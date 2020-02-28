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
    @ObservedObject var networkingManager: NetworkManager
    @State var shouldShowIndicator: Bool = true
    
    init() {
        networkingManager = NetworkManager()
    }
    
    var body: some View {
        return NavigationView {
            if networkingManager.loadingScansHistory{ ActivityIndicator(isAnimating: $networkingManager.loadingScansHistory) }
            List(networkingManager.scansHistory) { scan in
                NavigationLink(destination: DiseaseView(disease: scan.disease!, otherDiseases: [scan.disease2, scan.disease3], accuraces: [scan.accuracy, scan.accuracy2, scan.accuracy3], showNavigation: false)) {
                    HistoryCell(imageURL: NetworkManager.scanImageURLStrig +
                        "\(scan.id!)" + ".jpeg", diseaseName: scan.disease!.name, cropName: scan.crop!.name, createdAt: scan.createdAt)
                }
            }
            .navigationBarTitle("History")
        }
        .alert(isPresented: $shouldShowAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
        .onAppear() {
            self.networkingManager.getScansHistory(for: SessionManager.user!) { result in
                self.shouldShowIndicator = false
            }
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
                ImageContainer(imageURL: imageURL!)
                    // .resizable()
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
