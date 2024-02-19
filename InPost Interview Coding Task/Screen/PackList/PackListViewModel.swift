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

    func fetchPacks() async {
        do {
            let packs = try await packNetworking.getPacks()

            guard !packs.isEmpty else {
                sections = []
                state = .empty
                return
            }

            sections = createSections(from: packs)
            state = .list
        } catch {
            sections = []
            state = .error
        }
    }

    func retryFetchPack() async {
        state = .loading
        await fetchPacks()
    }
}

private extension PackListViewModel {
    func createSections(from packs: [Pack]) -> [PackListSection] {
        OrderedDictionary(grouping: packs, by: { $0.group })
            .sorted(by: {
                $0.key.order < $1.key.order
            })
            .map {
                .init(title: $0.key.title, packs: packMapper.map(packs: $0.value.sorted(by: <)))
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
