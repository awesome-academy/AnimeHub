//
//  DetailUseCase.swift
//  AnimeHub
//
//  Created by Tobi on 12/10/2023.
//

import Foundation
import RxSwift

protocol DetailUseCaseType {
    func getCharacters(input: CharactersRequest) -> Observable<[CharacterResponse]>
    func getStatistics(input: StatisticsRequest) -> Observable<StatisticsResponse>
}

struct DetailUseCase: DetailUseCaseType {
    func getCharacters(input: CharactersRequest) -> Observable<[CharacterResponse]> {
        return DetailImp().getCharacters(input: input)
    }

    func getStatistics(input: StatisticsRequest) -> Observable<StatisticsResponse> {
        return DetailImp().getStatistics(input: input)
    }
}
