//
//  RestAPIManager+Results.swift
//  RestAPIManager
//
//  Created by Monica Rondón on 10/30/19.
//  Copyright © 2019 Monica Rondón. All rights reserved.
//

import Foundation

extension RestAPIManager {

    public struct Results {

        public var data: Data?
        public var response: Response?
        public var error: Error?

        public init(data: Data?, response: Response?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }

        public init(_ data: Data?, _ urlResponse: URLResponse?, _ error: Error?) {
            self.init(data: data, response: Response(urlResponse), error: error)
        }

        public init(error: Error) {
            self.error = error
        }

        public init(_ customError: CustomError) {
            self.init(error: customError)
        }
    }
}
