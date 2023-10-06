//
//  Endpoint.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import Foundation

struct Endpoint {
    static var baseURL = "https://api.jikan.moe/v4/"
    static var animeDomain = baseURL + "anime"
    static var seasonDomain = baseURL + "seasons"
    static var topDomain = baseURL + "top/anime"
    static var recommendationDomain = baseURL + "recommendations/anime"
}
