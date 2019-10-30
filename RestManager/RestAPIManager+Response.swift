//
//  RestAPIManager+Response.swift
//  RestAPIManager
//
//  Created by Monica Rondón on 10/30/19.
//  Copyright © 2019 Monica Rondón. All rights reserved.
//

import Foundation

extension RestAPIManager {

    public struct Response {

        public var response: URLResponse?
        public var httpStatusCode: Int = 0
        public var headers = Entity()

        public init(_ response: URLResponse?) {

            guard let response = response else { return }

            self.response = response

            httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0

            if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {

                headerFields.forEach { headers.set("\($0.value)", for: "\($0.key)") }

            }
        }
    }

}
