//
//  Image.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import Foundation

struct ImageURL: Codable {
    var imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}
