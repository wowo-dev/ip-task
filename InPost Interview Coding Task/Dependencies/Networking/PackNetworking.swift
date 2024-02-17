//
//  PackNetworking.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

protocol PackNetworking: AnyObject {
    func getPacks() async throws -> [Pack]
}
