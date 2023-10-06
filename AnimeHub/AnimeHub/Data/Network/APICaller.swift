//
//  APICaller.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import Foundation
import Alamofire

final class APICaller {
    static let shared = APICaller()

    private init() {}

    func fetch <T: Codable> (url: String,
                             method: HTTPMethod,
                             parameters: [String: Any],
                             completion: @escaping (T?, Error?) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default)
            .response { (response) in
                guard let data = response.data else { return }
                let decoder = JSONDecoder()
                do {
                    switch response.result {
                    case .success:
                        let returnedResponse = try decoder.decode(T.self, from: data)
                        completion(returnedResponse, nil)
                    case .failure(let error):
                        completion(nil, error)
                    }
                } catch {
                    completion(nil, error)
                }
            }
    }
}
