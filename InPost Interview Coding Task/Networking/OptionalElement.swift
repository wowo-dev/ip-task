//
//  OptionalElement.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

/// Decodable object wrapper for optional decoding corrupted elements.
struct OptionalElement<Element: Decodable>: Decodable {
    let value: Element?

    init(from decoder: Decoder) throws {
        value = try? decoder
            .singleValueContainer()
            .decode(Element.self)
    }
}
