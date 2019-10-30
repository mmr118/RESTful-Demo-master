//
//  RestAPIManager+CustomError.swift
//  RestAPIManager
//
//  Created by Monica Rondón on 10/30/19.
//  Copyright © 2019 Monica Rondón. All rights reserved.
//

import Foundation

extension RestAPIManager {

    public enum CustomError: Error, LocalizedError {

        case failedToCreateRequest

        public var localizedDescription: String {

            switch self {
            case .failedToCreateRequest:
                return NSLocalizedString("Unable to create the URLRequest object", comment: "")
            }
        }

    }

}
