//
//  SeasonalRequest.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import Foundation
import Alamofire

final class SeasonalRequest: BaseRequest {
    required init(filter: String) {
        let parameter: [String: Any]  = [
            "filter": filter
        ]
        super.init(url: Endpoint.seasonDomain, requestType: .get, parameter: parameter)
    }
}
