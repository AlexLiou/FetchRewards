//
//  DecodableDefaultSource.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/1/22.
//

import Foundation

protocol Default {
    associatedtype Value

    static var defaultValue: Value { get }
}

@propertyWrapper
struct DefaultDecodable<D: Default>: Codable where D.Value: Codable {
    let wrappedValue: D.Value

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(D.Value.self)
    }

    init() {
        wrappedValue = D.defaultValue
    }
}


extension KeyedDecodingContainer {
    func decode<D>(_ type: DefaultDecodable<D>.Type, forKey key: Key) throws -> DefaultDecodable<D> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}

protocol EmptyInitializable {
    init()
}

extension Array: EmptyInitializable {}
extension String: EmptyInitializable {}

struct EmptyDefault<Value: EmptyInitializable>: Default {
    static var defaultValue: Value {
        .init()
    }
}

enum CommonDefault {
    struct Empty<Value: EmptyInitializable>: Default {
        static var defaultValue: Value {
            .init()
        }
    }

    struct Zero<Value: Numeric>: Default {
        static var defaultValue: Value {
            .zero
        }
    }

    struct One<Value: Numeric>: Default {
        static var defaultValue: Value {
            1
        }
    }

    struct MinusOne<Value: Numeric>: Default {
        static var defaultValue: Value {
            -1
        }
    }
}

enum DefaultBy {
    typealias Empty<Value: Codable & EmptyInitializable> = DefaultDecodable<CommonDefault.Empty<Value>>

    typealias Zero<Value: Codable & Numeric> = DefaultDecodable<CommonDefault.Zero<Value>>

    typealias One<Value: Codable & Numeric> = DefaultDecodable<CommonDefault.One<Value>>

    typealias MinusOne<Value: Codable & Numeric> = DefaultDecodable<CommonDefault.MinusOne<Value>>
}
