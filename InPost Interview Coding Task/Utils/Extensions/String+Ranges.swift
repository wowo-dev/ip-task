//
//  String+Ranges.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

extension String {
    func ranges(of substring: String) -> [NSRange] {
        var ranges = [NSRange]()
        var startIndex = self.startIndex

        while let range = self.range(of: substring, range: startIndex..<self.endIndex) {
            let nsRange = NSRange(range, in: self)
            ranges.append(nsRange)
            startIndex = range.upperBound
        }

        return ranges
    }
}
