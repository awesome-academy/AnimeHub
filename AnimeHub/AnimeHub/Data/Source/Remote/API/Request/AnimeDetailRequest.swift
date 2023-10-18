//
//  AnimeDetailRequest.swift
//  AnimeHub
//
//  Created by Tobi on 17/10/2023.
//

import Foundation
import Alamofire

final class AnimeDetailRequest: BaseRequest {
    required init(id: Int) {
        let url = Endpoint.animeDomain + "/\(id)"
        super.init(url: url, requestType: .get)
    }
}
