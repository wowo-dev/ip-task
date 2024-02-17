//
//  PackNetworking.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 04/11/2022.
//

import Foundation

class PackNetworking {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func getPacks() async throws -> [Pack] {
        let url = Bundle.main.url(forResource: "packs", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let packs = try decodeValidListElements(Pack.self, from: data)
        return packs
    }

    /// Decodes array of only valid Decodable elements from Data. Corrupted elements are omitted.
    /// - Parameters:
    ///   - type: The type of the element to decode.
    ///   - arrayData: The array data to decode from.
    /// - Returns: An array of the elements of the requested type.
    private func decodeValidListElements<T: Decodable>(_ type: T.Type, from arrayData: Data) throws -> [T] {
        let result = try jsonDecoder.decode([OptionalElement<T>].self, from: arrayData)
        let validElements = result.compactMap { $0.value }
        return validElements
    }
}
