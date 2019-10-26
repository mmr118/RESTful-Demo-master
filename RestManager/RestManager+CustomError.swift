//
//  RestManager+CustomError.swift
//  RestManager
//
//  Created by Rondon Monica on 26.10.19.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

extension RestManager {

    enum CustomError: Error, LocalizedError {
        case failedToCreateRequest

        public var localizedDescription: String {

            switch self {
            case .failedToCreateRequest:
                return NSLocalizedString("Unable to create the URLRequest object", comment: "")
            }
        }

    }

}
