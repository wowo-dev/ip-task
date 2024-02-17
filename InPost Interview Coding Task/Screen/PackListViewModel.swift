//
//  PackListViewModel.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Combine

final class PackListViewModel {
    private let packNetworking = PackNetworking()

    @Published private(set) var packs = [Pack]()

    func fetchPacks() {

    }
}
