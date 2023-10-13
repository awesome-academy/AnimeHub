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
        let selectTrigger: Driver<IndexPath>
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

        input.selectTrigger
            .withLatestFrom(result) { indexPath, animeList in
                return animeList[indexPath.row]
            }
            .drive(onNext: { anime in
                self.navigator.goDetail(anime: anime)
            })
            .disposed(by: disposeBag)

        return Output(animeList: result, isLoading: indicator.asDriver())
    }
}
