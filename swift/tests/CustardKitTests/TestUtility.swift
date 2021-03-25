//
//  File.swift
//  
//
//  Created by β α on 2021/03/25.
//

import Foundation
extension Encodable where Self: Decodable {
    public func quickEncode() -> Data? {
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(self)
        return encoded
    }

    public static func quickDecode(target: Data?) -> Self? {
        let decoder = JSONDecoder()
        let decoded = try? decoder.decode(Self.self, from: target ?? Data())
        return decoded
    }

    public static func quickDecode(target: String) -> Self? {
        let decoder = JSONDecoder()
        let decoded = try? decoder.decode(Self.self, from: target.data(using: .utf8) ?? Data())
        return decoded
    }

    public func quickEncodeDecode() -> Self? {
        return Self.quickDecode(target: self.quickEncode())
    }
}
