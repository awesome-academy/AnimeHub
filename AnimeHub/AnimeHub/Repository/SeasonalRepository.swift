//
//  SeasonalRepository.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol SeasonalRepository {
    func fetchAnime(input: SeasonalRequest) -> Observable<[Anime]>
}

final class SeasonalRepositoryImpl: SeasonalRepository {

    func fetchAnime(input: SeasonalRequest) -> Observable<[Anime]> {
        return APICaller.shared.fetch(input: input)
            .map { (response: ListAnimeResponse) in
                return response.data
            }.catchErrorJustReturn([])
    }
}
