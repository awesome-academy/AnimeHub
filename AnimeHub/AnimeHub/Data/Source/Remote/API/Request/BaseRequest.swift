//
//  BaseRequest.swift
//  AnimeHub
//
//  Created by Tobi on 09/10/2023.
//

import Foundation
import Alamofire

class BaseRequest: NSObject {

    var url = ""
    var requestType = Alamofire.HTTPMethod.get
    var parameter: [String: Any]?

    init(url: String) {
        super.init()
        self.url = url
    }

    init(url: String, requestType: Alamofire.HTTPMethod) {
        super.init()
        self.url = url
        self.requestType = requestType
    }

    init(url: String, requestType: Alamofire.HTTPMethod, parameter: [String: Any]?) {
        super.init()
        self.url = url
        self.requestType = requestType
        self.parameter = parameter
    }

    var encoding: ParameterEncoding {
        switch requestType {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
