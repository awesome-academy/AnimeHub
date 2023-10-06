//
//  Studio.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import Foundation

struct BriefInfo: Codable {
    var malId: Int
    var type: String
    var name: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case type, name, url
    }
}
