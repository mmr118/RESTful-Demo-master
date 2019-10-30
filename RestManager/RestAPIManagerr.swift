//
//  RestAPIManagerr.swift
//  RestAPIManager
//
//  Created by Monica Rondón on 10/30/19.
//  Copyright © 2019 Monica Rondón. All rights reserved.
//

import Foundation

public class RestAPIManager {

    var requestHTTPHeaders = Entity()
    var urlQueryParameters = Entity()
    var httpBodyParameters = Entity()
    var httpBody: Data?

    // MARK: - Public Methods
    public init() { }
    
    public func makeRequest(to url: URL, using httpMethod: HTTPMethod, completion: @escaping (Results) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in

            guard let strongSelf = self else { return }

            let targetURL = strongSelf.addURLQueryParameters(to: url)
            let httpBody =  strongSelf.getHttpBody()

            guard let request = strongSelf.prepareRequest(targetURL, body: httpBody, method: httpMethod) else { return completion(Results(.failedToCreateRequest)) }

            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, urlResponse, error) in
                completion(Results(data, urlResponse, error))
            }

            task.resume()
        }
    }

    public func getData(from url: URL, completion: @escaping (Data?) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, _, _) in
                completion(data)
            }

            task.resume()
        }
    }

    // MARK: - Private Methods
    private func addURLQueryParameters(to url: URL) -> URL {

        guard urlQueryParameters.count > 0 else { return url }

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }

        urlComponents.queryItems = urlQueryParameters.allValues.map { URLQueryItem(name: $0.key, value: $0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)) }

        return urlComponents.url ?? url

    }

    private func getHttpBody() -> Data? {

        guard let contentType = requestHTTPHeaders.value(for: "Content-Type") else { return nil }

        switch true {
        case contentType.contains("application/json"):
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues, options: [.prettyPrinted, .sortedKeys])

        case contentType.contains("application/x-www-form-urlencoded"):
            let bodyParts = httpBodyParameters.allValues.map { "\($0)=\(String(describing: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))" }
            return bodyParts.joined(separator: "&").data(using: .utf8)

        default:
            return httpBody
        }

    }

    private func prepareRequest(_ url: URL?, body: Data?, method: HTTPMethod) -> URLRequest? {
        guard let url = url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        requestHTTPHeaders.allValues.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        request.httpBody = body
        return request
    }

}
