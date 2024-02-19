//
//  PackView+Model.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

extension PackView {
    struct Model: Equatable {
        let id: String
        let status: String
        let sender: String
        let shipmentIconName: String
        let dateTitle: String?
        let attributedDate: NSAttributedString?
    }
}
