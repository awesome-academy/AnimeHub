//
//  SearchUseCase.swift
//  AnimeHub
//
//  Created by Tobi on 10/10/2023.
//

import Foundation
import RxSwift

protocol SearchUseCaseType {
    func getSearchResult(input: SearchRequest) -> Observable<[Anime]>
}

struct SearchUseCase: SearchUseCaseType {
    func getSearchResult(input: SearchRequest) -> Observable<[Anime]> {
        return SearchRepositoryImpl().searchAnime(input: input)
    }
}
