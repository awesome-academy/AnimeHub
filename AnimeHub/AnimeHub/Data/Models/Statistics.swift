//
//  Statistics.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import Foundation

struct Statistics: Codable {
    var watching: Int
    var completed: Int
    var onHold: Int
    var dropped: Int
    var planToWatch: Int
    var total: Int
    var scores: [Score]

    enum CodingKeys: String, CodingKey {
        case watching
        case completed
        case dropped
        case total
        case scores
        case onHold = "on_hold"
        case planToWatch = "plan_to_watch"
    }
}
