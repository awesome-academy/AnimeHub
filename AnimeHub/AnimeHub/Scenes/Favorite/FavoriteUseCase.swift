//
//  FavoriteUseCase.swift
//  AnimeHub
//
//  Created by Tobi on 13/10/2023.
//

import Foundation
import RxSwift

protocol FavoriteUseCaseType {
    func fetchEntities() -> Observable<[AnimeEntity]>
    func deleteEntity(malId: Int) -> Observable<Void>
}

struct FavoriteUseCase: FavoriteUseCaseType {

    let databaseManager = CoreDataManager.shared

    func fetchEntities() -> Observable<[AnimeEntity]> {
        return databaseManager.getAllFavourites()
    }

    func deleteEntity(malId: Int) -> Observable<Void> {
        return databaseManager.deleteFavourite(id: malId)
    }
}
