//
//  CharacterRequest.swift
//  AnimeHub
//
//  Created by Tobi on 16/10/2023.
//

import Foundation
import Alamofire

final class CharactersRequest: BaseRequest {
    required init(id: Int) {
        let url = Endpoint.animeDomain + "/\(id)" + "/characters"
        super.init(url: url, requestType: .get)
    }
}
