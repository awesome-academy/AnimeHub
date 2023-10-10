//
//  RecommendationsRepository.swift
//  AnimeHub
//
//  Created by Tobi on 06/10/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol RecommendationsRepository {
    func fetchRecommendations(input: AnimeRequest) -> Observable<[Anime]>
}

final class RecommendationsImp: RecommendationsRepository {

    func fetchRecommendations(input: AnimeRequest) -> Observable<[Anime]> {
        return APICaller.shared.fetch(input: input)
            .map { (response: ListAnimeResponse) in
                return response.data
            }.catchErrorJustReturn([])
    }
}
