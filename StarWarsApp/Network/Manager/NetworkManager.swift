//
//  NetworkManager.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import Foundation

enum APIRequestError: Error {
    case invalidUrl
    case invalidData
    case invalidResponse
}

extension APIRequestError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidData:
            return "Invalid Data"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}

class NetworkManager {
    /// <#Description#>
    /// - Parameter apiRouter: <#apiRouter description#>
    /// - Returns: <#description#>
    class func request<T: Codable>(apiRouter: APIRouter) async throws -> T {
        var components = URLComponents()
        components.host = apiRouter.host
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
        components.queryItems = apiRouter.parameters

        guard let url = components.url else {
            throw APIRequestError.invalidUrl
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRouter.httpMethod.rawValue

        let session = URLSession(configuration: .default)
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in

                if let error = error {
                    return continuation.resume(with: .failure(error))
                }

                guard let data = data else {
                    return continuation.resume(with: .failure(APIRequestError.invalidData))
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
                {
                    return continuation.resume(with: .failure(APIRequestError.invalidResponse))
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        return continuation.resume(with: .success(decodedResponse))
                    }
                } catch {
                    return continuation.resume(with: .failure(error))
                }
            }
            dataTask.resume()
        }
    }
}
