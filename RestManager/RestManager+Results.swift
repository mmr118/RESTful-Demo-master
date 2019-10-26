//
//  RestManager+Results.swift
//  RestManager
//
//  Created by Rondon Monica on 26.10.19.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

extension RestManager {
    
    struct Results {

        var data: Data?
        var response: Response?
        var error: Error?

        init(data: Data?, response: Response?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }

        init(error: Error) {
            self.error = error
        }
    }
}
