//
//  PackListViewModel.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Combine
import OrderedCollections
import Factory

final class PackListViewModel {
    @Injected(\.packNetworking) var packNetworking
    @Injected(\.packModelMapper) var packMapper

    @Published private(set) var state = PackListState.loading
    @Published private(set) var sections = [PackListSection]()

    func fetchPacks() {
        Task {
            do {
                let packs = try await packNetworking.getPacks()
                sections = createSections(from: packs)
                state = .list
            } catch {
                sections = []
            }
        }
    }
}

private extension PackListViewModel {
    func createSections(from packs: [Pack]) -> [PackListSection] {
        OrderedDictionary(grouping: packs, by: { $0.group })
            .sorted(by: {
                $0.key.order < $1.key.order
            })
            .map {
                .init(title: $0.key.title, packs: packMapper.map(packs: $0.value))
            }
    }
}

private extension Pack {
    var group: PackGroup {
        isInDelivery ? .inDelivery : .other
    }

    var isInDelivery: Bool {
        [.outForDelivery, .readyToPickup].contains(status)
    }
}
