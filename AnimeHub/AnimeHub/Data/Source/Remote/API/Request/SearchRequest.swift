//
//  SearchRequest.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import Foundation
import Alamofire

final class SearchRequest: BaseRequest {
    required init(keyword: String) {
        let parameter: [String: Any]  = [
            "q": keyword
        ]
        super.init(url: Endpoint.animeDomain, requestType: .get, parameter: parameter)
    }
}
