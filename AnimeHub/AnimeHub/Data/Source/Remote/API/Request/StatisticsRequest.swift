//
//  StatisticsRequest.swift
//  AnimeHub
//
//  Created by Tobi on 16/10/2023.
//

import Foundation
import Alamofire

final class StatisticsRequest: BaseRequest {
    required init(id: Int) {
        let url = Endpoint.animeDomain + "/\(id)" + "/statistics"
        super.init(url: url, requestType: .get)
    }
}
