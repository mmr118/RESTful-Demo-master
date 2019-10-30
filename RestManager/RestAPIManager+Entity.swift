//
//  RestAPIManager+Entity.swift
//  RestAPIManager
//
//  Created by Monica Rondón on 10/30/19.
//  Copyright © 2019 Monica Rondón. All rights reserved.
//

import Foundation

extension RestAPIManager {

    public struct Entity {

        private var values: [String: String] = [:]
        
        public var count: Int { return values.count }
        public var allValues: [String: String] { return values }

        public mutating func set(_ value: String, for key: String) {
            values[key] = value
        }

        public func value(for key: String) -> String? {
            return values[key]
        }

    }
}
