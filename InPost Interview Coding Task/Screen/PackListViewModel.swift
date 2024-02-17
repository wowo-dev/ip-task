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
        Task {
            do {
                packs = try await packNetworking.getPacks()
            } catch {
                packs = []
            }
        }
    }
}

private extension PackNetworking {
    func getPacks() async throws -> [Pack] {
        try await withCheckedThrowingContinuation { continuation in
            getPacks { result in
                continuation.resume(with: result)
            }
        }
    }
}
