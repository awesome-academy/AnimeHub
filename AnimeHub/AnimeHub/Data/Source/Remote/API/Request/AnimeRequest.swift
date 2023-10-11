//
//  RecommendationsRequest.swift
//  AnimeHub
//
//  Created by Tobi on 09/10/2023.
//

import Foundation

final class AnimeRequest: BaseRequest {
    required init() {
        super.init(url: Endpoint.topDomain,
                   requestType: .get,
                   parameter: [:])
    }
}
