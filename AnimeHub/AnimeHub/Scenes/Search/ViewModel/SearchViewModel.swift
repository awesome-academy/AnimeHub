//
//  SearchViewModel.swift
//  AnimeHub
//
//  Created by Tobi on 10/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

struct SearchViewModel {
    let useCase: SearchUseCaseType
    let navigator: SearchNavigatorType
}

extension SearchViewModel: ViewModelType {

    struct Input {
        let load: Driver<Void>
        let keyword: Driver<String>
        let searchTrigger: Driver<Void>
    }

    struct Output {
        let searchResult: Driver<[Anime]>
        let isSearching: Driver<Bool>
    }

    func transform(_ input: SearchViewModel.Input, disposeBag: DisposeBag) -> Output {

        let activityIndicator = ActivityIndicator()

        let searchResult = input.searchTrigger.withLatestFrom(input.keyword)
            .map({ (keyword) -> SearchRequest in
                return SearchRequest(keyword: keyword)
            })
            .flatMapLatest { inputRequest in
                return self.useCase.getSearchResult(input: inputRequest)
                    .trackActivity(activityIndicator)
                    .asDriver(onErrorJustReturn: [])
            }

        return Output(
            searchResult: searchResult,
            isSearching: activityIndicator.asDriver())
    }

}
