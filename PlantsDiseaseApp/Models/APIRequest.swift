//
//  APIRequest.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/16/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decondingProblem
    case encodingProblem
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
    
    
    func scanDisease(with scanRequest: Scan, completion: @escaping(Result<APIResult, APIError>) -> Void) {
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
