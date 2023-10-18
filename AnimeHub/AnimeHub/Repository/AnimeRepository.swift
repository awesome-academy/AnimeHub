//
//  AnimeRepository.swift
//  AnimeHub
//
//  Created by Tobi on 17/10/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol AnimeRepository {
    func fetchAnime(input: AnimeDetailRequest) -> Observable<Anime>
}

final class AnimeRepositoryImp: AnimeRepository {
    func fetchAnime(input: AnimeDetailRequest) -> Observable<Anime> {
        return APICaller.shared.fetch(input: input)
            .map { (response: AnimeResponse) in
                return response.data
            }.catchErrorJustReturn(
                Constant.Object.defaultAnime
            )
    }
}
