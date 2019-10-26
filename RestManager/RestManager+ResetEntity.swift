//
//  RestManager+ResetEntity.swift
//  RestManager
//
//  Created by Rondon Monica on 26.10.19.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

extension RestManager {

    struct RestEntity {
        
        private var values: [String: String] = [:]

        public var count: Int { return values.count }

        mutating func set(_ value: String, for key: String) {
            values[key] = value
        }

        func value(for key: String) -> String? {
            return values[key]
        }

        func allValues() -> [String: String] {
            return values
        }

    }
}
