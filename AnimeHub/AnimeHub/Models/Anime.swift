//
//  Anime.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import Foundation

struct Anime: Codable {
    var malId: Int
    var url: String
    var images: ImageResponse
    var title: String
    var type: String
    var source: String
    var episodes: Int
    var status: String
    var duration: String
    var rating: String
    var score: Double
    var scoredBy: Int
    var rank: Int
    var popularity: Int
    var members: Int
    var favorites: Int
    var synopsis: String
    var season: String
    var year: Int
    var studios: [BriefInfo]
    var genres: [BriefInfo]

    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case url, images, title, type, source, episodes, status, duration, rating, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, season, year, studios, genres
    }
}
