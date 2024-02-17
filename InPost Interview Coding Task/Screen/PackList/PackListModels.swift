//
//  PackListModels.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

struct PackListSection {
    let title: String
    let packs: [Pack]
}

enum PackGroup: CaseIterable {
    case inDelivery
    case other

    var title: String {
        switch self {
        case .inDelivery: "Gotowe do odbioru"
        case .other: "Pozostałe"
        }
    }

    /// The order indicator of given ``PackGroup``. Groups with the highest priorities comes first.
    var order: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}
