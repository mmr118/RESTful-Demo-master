//
//  RestAPIManager+HTTPMethod.swift
//  RestAPIManager
//
//  Created by Monica Rondón on 10/30/19.
//  Copyright © 2019 Monica Rondón. All rights reserved.
//

import Foundation

extension RestAPIManager {

    public enum HTTPMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }

}
