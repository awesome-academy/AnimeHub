//
//  HomeUseCase.swift
//  AnimeHub
//
//  Created by Tobi on 07/10/2023.
//

import Foundation
import RxSwift

protocol HomeUseCaseType {
    func getRecommendations() -> Observable<[Anime]>
}

struct HomeUseCase: HomeUseCaseType {
    func getRecommendations() -> Observable<[Anime]> {
        return RecommendationsImp().fetchRecommendations(input: AnimeRequest())
    }
}
