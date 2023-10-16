//
//  DetailViewController.swift
//  AnimeHub
//
//  Created by Tobi on 12/10/2023.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import RxSwiftUtilities

struct DetailViewModel {
    let useCase: DetailUseCaseType
    let navigator: DetailNavigatorType
}

extension DetailViewModel: ViewModelType {
    struct Input {
        let id: Driver<Int>
        let load: Driver<Void>
        let selectTrigger: Driver<IndexPath>
    }

    struct Output {
        var isLoading: Driver<Bool>
        var characters: Driver<[CharacterResponse]>
        var statistics: Driver<StatisticsResponse>
    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let indicator = ActivityIndicator()

        let characters = input.load
            .withLatestFrom(input.id).map({ (malId) -> CharactersRequest in
                return CharactersRequest(id: malId)
            })
            .flatMapLatest { request in
                return self.useCase.getCharacters(input: request)
                    .trackActivity(indicator)
                    .asDriver(onErrorJustReturn: [])
            }

        let statistics = input.load
            .withLatestFrom(input.id).map({ (malId) -> StatisticsRequest in
                return StatisticsRequest(id: malId)
            })
            .flatMapLatest { request in
                return self.useCase.getStatistics(input: request)
                    .trackActivity(indicator)
                    .asDriver(onErrorJustReturn:
                                StatisticsResponse(data: Constant.Object.defaultStatistics)
                    )
            }

        input.selectTrigger
            .withLatestFrom(characters) { indexPath, result in
                return result[indexPath.row]
            }
            .drive(onNext: { anime in
                self.navigator.goToLink(url: URL(string: anime.character.url))
            })
            .disposed(by: disposeBag)

        return Output(
            isLoading: indicator.asDriver(),
            characters: characters,
            statistics: statistics
        )
    }
}
