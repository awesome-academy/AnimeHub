//
//  DetailRepository.swift
//  AnimeHub
//
//  Created by Tobi on 16/10/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol DetailRepository {
    func getCharacters(input: CharactersRequest) -> Observable<[CharacterResponse]>
    func getStatistics(input: StatisticsRequest) -> Observable<StatisticsResponse>
}

final class DetailImp: DetailRepository {

    func getCharacters(input: CharactersRequest) -> Observable<[CharacterResponse]> {
        return APICaller.shared.fetch(input: input)
            .map { (response: ListCharactersResponse) in
                return response.data
            }.catchErrorJustReturn([])
    }

    func getStatistics(input: StatisticsRequest) -> Observable<StatisticsResponse> {
        return APICaller.shared.fetch(input: input)
            .map { (response: StatisticsResponse) in
                return response
            }.catchErrorJustReturn(
                StatisticsResponse(
                    data: Constant.Object.defaultStatistics
                )
            )
    }
}
