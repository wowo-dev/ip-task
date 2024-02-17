//
//  PackModelMapper.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

protocol PackModelMapper: AnyObject {
    func map(packs: [Pack]) -> [PackView.Model]
}
