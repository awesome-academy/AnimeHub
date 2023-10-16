//
//  Char.swift
//  AnimeHub
//
//  Created by Tobi on 16/10/2023.
//

import Foundation

struct Char: Codable {
    let malID: Int
    let url: String
    let images: ImageResponse
    let name: String

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url
        case images
        case name
    }
}
