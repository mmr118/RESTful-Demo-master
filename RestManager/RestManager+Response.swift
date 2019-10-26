//
//  RestManager+Response.swift
//  RestManager
//
//  Created by Rondon Monica on 26.10.19.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

extension RestManager {

    struct Response {

        var response: URLResponse?
        var httpStatusCode: Int = 0
        var headers = RestEntity()

        init(_ response: URLResponse?) {

            guard let response = response else { return }

            self.response = response

            httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0

            if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {

                headerFields.forEach { headers.set("\($0.value)", for: "\($0.key)") }

            }
        }
    }

}
