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
    func addToFavorite(anime: Anime) -> Observable<Void>
    func checkEntityExist(id: Int) -> Observable<Bool>
}

struct HomeUseCase: HomeUseCaseType {

    let databaseManager = CoreDataManager.shared

    func getRecommendations() -> Observable<[Anime]> {
        return RecommendationsImp().fetchRecommendations(input: AnimeRequest())
    }

    func addToFavorite(anime: Anime) -> Observable<Void> {
        return databaseManager.saveToDatabase(anime: anime)
    }

    func checkEntityExist(id: Int) -> Observable<Bool> {
        return databaseManager.checkEntityExist(id: id)
    }
}
