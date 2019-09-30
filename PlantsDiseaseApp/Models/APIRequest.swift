//
//  APIRequest.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/16/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation
import UIKit
import Combine

enum APIError: Error {
    case responseProblem
    case decondingProblem
    case encodingProblem
}

class NetworkManager: ObservableObject {

    var didChangeHScansistory = PassthroughSubject<NetworkManager, Never>()
     
    @Published var scansHistory = [Scan]()
    
    let resourceURL: URL
    init(endpoint: String, user: User) {
           let reourceString = "https://plantsdiseaseweb.azurewebsites.net/\(endpoint)"
           guard let resourceURL = URL(string: reourceString) else{fatalError()}
           self.resourceURL = resourceURL
       }
    
    func getScansHistory(for user: User, completion: @escaping(Result<ScanHistoryRequest, APIError>) -> Void) {
          do {
               var urlRequest = URLRequest(url: resourceURL)
               urlRequest.httpMethod = "POST"
               urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
               urlRequest.httpBody = try JSONEncoder().encode(user)
               let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                   guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                       completion(.failure(.responseProblem))
                       return
                   }
                   do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                       let response = try decoder.decode(ScanHistoryRequest.self, from: jsonData)
                       
                       if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                           print(JSONString)
                       }
                    
                        DispatchQueue.main.async {
                            self.scansHistory = response.scans
                        }
                      // completion(.success(response))
                    
                   } catch {
                       completion(.failure(.decondingProblem))
                   }
               }
               dataTask.resume()
           } catch {
               completion(.failure(.encodingProblem))
           }
       }
}


struct APIRequest {
    
    let resourceURL: URL
    init(endpoint: String) {
        let reourceString = "https://plantsdiseaseweb.azurewebsites.net/\(endpoint)"
        guard let resourceURL = URL(string: reourceString) else{fatalError()}
        self.resourceURL = resourceURL
    }
    
    func add(user: User, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(APIResult.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func authenticate(user:User, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(APIResult.self, from: jsonData)
                    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
                    {
                        print(JSONString)
                    }
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func forgotPassword(of user:User, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, data != nil else {
                    completion(.failure(.responseProblem))
                    return
                }
                completion(.success(APIResult(result: "success")))
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func changePasswordReuquest(with forgotPasswordRequest: ChangePasswordRequest, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(forgotPasswordRequest)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(APIResult.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func changeEmailRequest(with changeEmailRequest: ChangeEmailRequest, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(changeEmailRequest)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(APIResult.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    
    func scanDisease(with scanRequest: Scan, completion: @escaping(Result<Disease, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(scanRequest)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(Disease.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func UploadRequest(image: UIImage) {
        let url = URL(string: "https://plantsdiseaseweb.azurewebsites.net/plant/upload_photo_mobile")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let image_data = image.pngData()
        if(image_data == nil) {
            return
        }
        let body = NSMutableData()
        let fname = "test.png"
        let mimetype = "image/png"
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        request.httpBody = body as Data
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            guard ((data) != nil), let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                print(dataString)
            }
        })
        
        task.resume()
    }
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }
}


struct APIResult: Decodable{
    var result: String
    var user: User?
}

struct ChangePasswordRequest: Encodable {
    var id: Int
    var oldPassword: String
    var newPassword: String
}

struct ChangeEmailRequest: Encodable {
    var email: String
    var id: Int
}
