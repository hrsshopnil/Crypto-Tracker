//
//  NetworkingManager.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 2/12/24.
//

import Combine
import Foundation

class NetworkManager {
    private var cancellable: AnyCancellable?
    
    /// Fetches data from a URL and decodes it into the specified type.
    /// - Parameters:
    ///   - urlString: The URL string to fetch data from.
    ///   - type: The type to decode the data into.
    ///   - completion: A closure that handles the result, either the decoded data or an error.
    func fetchData<T: Decodable>(from urlString: String, decodingTo type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: type, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { result in
                completion(.success(result))
            })
    }
}

