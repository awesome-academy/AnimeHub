//
//  SeasonalUseCase.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import Foundation
import RxSwift

protocol SeasonalUseCaseType {
    func getAnimeInSeason(input: SeasonalRequest) -> Observable<[Anime]>
}

struct SeasonalUseCase: SeasonalUseCaseType {
    func getAnimeInSeason(input: SeasonalRequest) -> Observable<[Anime]> {
        return SeasonalRepositoryImpl().fetchAnime(input: input)
    }
}
