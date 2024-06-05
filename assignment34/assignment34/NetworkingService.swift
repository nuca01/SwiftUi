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
        
        guard var components = URLComponents(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
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

//let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
//var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//let queryItems: [URLQueryItem] = [
//  URLQueryItem(name: "language", value: "en-US"),
//  URLQueryItem(name: "page", value: "1"),
//]
//components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//
//var request = URLRequest(url: components.url!)
//request.httpMethod = "GET"
//request.timeoutInterval = 10
//request.allHTTPHeaderFields = [
//  "accept": "application/json",
//  "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ODRhNjIxNjY0NjZlZjc1NzYwNzQ5MjgyMmE3MmJkOSIsInN1YiI6IjY2NjBhZDU4ZTg1NjZiNmE4Y2EyMjhlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7cIzniNLbg7LZB5Z-IjJP7Ftd_dI9F8863UEsREQ0yk"
//]
//
//let (data, _) = try await URLSession.shared.data(for: request)
//print(String(decoding: data, as: UTF8.self))
