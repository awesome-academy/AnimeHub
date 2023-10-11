//
//  SearchRepository.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol SearchRepository {
    func searchAnime(input: SearchRequest) -> Observable<[Anime]>
}

final class SearchRepositoryImpl: SearchRepository {

    func searchAnime(input: SearchRequest) -> Observable<[Anime]> {
        return APICaller.shared.fetch(input: input)
            .map { (response: ListAnimeResponse) in
                return response.data
            }.catchErrorJustReturn([])
    }
}
