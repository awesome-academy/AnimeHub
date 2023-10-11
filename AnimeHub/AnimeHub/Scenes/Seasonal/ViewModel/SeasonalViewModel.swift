//
//  SeasonalViewModel.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import RxSwiftUtilities

struct SeasonalViewModel {
    let useCase: SeasonalUseCaseType
    let navigator: SeasonalNavigatorType
}

extension SeasonalViewModel: ViewModelType {
    struct Input {
        let load: Driver<Void>
        let filter: Driver<String>
    }

    struct Output {
        var animeList: Driver<[Anime]>
        var isLoading: Driver<Bool>
    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let indicator = ActivityIndicator()

        let result = input.load.withLatestFrom(input.filter)
            .map({ (filter) -> SeasonalRequest in
                return SeasonalRequest(filter: filter)
            })
            .flatMapLatest { inputRequest in
                return self.useCase.getAnimeInSeason(input: inputRequest)
                    .trackActivity(indicator)
                    .asDriver(onErrorJustReturn: [])
            }

        return Output(animeList: result, isLoading: indicator.asDriver())
    }
}
