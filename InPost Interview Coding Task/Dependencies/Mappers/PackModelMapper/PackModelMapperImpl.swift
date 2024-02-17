//
//  PackModelMapperImpl.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

final class PackModelMapperImpl {

}

// MARK: - PackModelMapper
extension PackModelMapperImpl: PackModelMapper {
    func map(packs: [Pack]) -> [PackView.Model] {
        packs.map(\.cellModel)
    }
}

private extension Pack {
    var cellModel: PackView.Model {
        .init(id: id, status: status.rawValue, sender: sender, shipmentIconName: "", dateTitle: nil, date: nil)
    }
}
