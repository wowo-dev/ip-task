//
//  PackListModels.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

enum PackListState {
    case loading
    case list
}

struct PackListSection {
    let title: String
    let packs: [PackView.Model]
}

enum PackGroup: CaseIterable {
    case inDelivery
    case other

    var title: String {
        switch self {
        case .inDelivery: "pack_group_in_delivery".localized
        case .other: "pack_group_other".localized
        }
    }

    /// The order indicator of given ``PackGroup``. Groups with the highest priorities comes first.
    var order: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}
