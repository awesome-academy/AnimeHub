//
//  BottomSheetViewModel.swift
//  AnimeHub
//
//  Created by Tobi on 13/10/2023.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import RxSwiftUtilities

struct BottomSheetViewModel {
    let useCase: HomeUseCaseType
    let anime: Anime
}

extension BottomSheetViewModel: ViewModelType {

    struct Input {
        let load: Driver<Void>
        let addTrigger: Driver<Void>
        let score: Driver<Double>
        let status: Driver<String>
    }

    struct Output {
        var isLoading: Driver<Bool>
        var isSaved: Driver<Bool>
    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {

        let activityIndicator = ActivityIndicator()

        let isSaved = BehaviorRelay<Bool>(value: false)

        let checkExist = self.useCase.checkEntityExist(id: anime.malId)

        let parameters = Driver.combineLatest(input.score, input.status) { (score, status) in
            return (score: score, status: status)
        }

        input.load
            .flatMapLatest { _ in
                checkExist.asDriver(onErrorJustReturn: false)
            }
            .drive(isSaved)
            .disposed(by: disposeBag)

        input.addTrigger
            .withLatestFrom(parameters)
            .flatMapLatest { parameters in
            self.useCase.addToFavorite(anime:
                                        Anime(
                                            malId: anime.malId,
                                            url: anime.url,
                                            images: anime.images,
                                            title: anime.title,
                                            type: anime.type,
                                            source: anime.source,
                                            status: parameters.status,
                                            score: parameters.score,
                                            studios: anime.studios,
                                            genres: anime.genres
                                        ))
                .asDriver(onErrorDriveWith: .empty())
                
        }.drive()
        .disposed(by: disposeBag)

        return Output(isLoading: activityIndicator.asDriver(), isSaved: isSaved.asDriver())
    }
}
