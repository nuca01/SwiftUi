//
//  NetworkingService.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import Foundation
public enum NetworkError: Error {
    case decodeError
    case invalidURL
    case noData
}

struct NetworkingService {
    public static var networkService = NetworkingService()
    
    private init() {}
    
    public func getData<T: Decodable> (urlString: String, queryItems: [URLQueryItem], headers: [String: String], completion: @escaping (Result<T,Error>) -> (Void)) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("wrong response")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
                
            } catch {
                completion(.failure(NetworkError.decodeError))
            }
        }.resume()
    }
}
