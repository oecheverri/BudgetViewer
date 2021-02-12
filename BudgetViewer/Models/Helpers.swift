//
//  Helpers.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-02-06.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation



extension KeyedDecodingContainer {
    /// Decodes an optional value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - parameter defaultValue: The type to return if the key is not present.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type, otherwise returns the default value.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    func decodeOptional<T>(type: T.Type, forKey key: K, defaultingTo defaultValue: T) throws -> T where T: Decodable {
        if contains(key) {
            let decodedValue = try decode(T.self, forKey: key)
            return decodedValue
        } else {
            return defaultValue
        }
    }
}
