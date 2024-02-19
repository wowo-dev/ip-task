//
//  Container.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation
import Factory

extension Container {
    var packNetworking: Factory<PackNetworking> {
        self { PackNetworkingImpl() }
            .shared
    }

    var packModelMapper: Factory<PackModelMapper> {
        self { PackModelMapperImpl() }
            .shared
    }
}
