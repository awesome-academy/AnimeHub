//
//  FavoriteViewModel.swift
//  AnimeHub
//
//  Created by Tobi on 13/10/2023.
//

import Foundation
import RxCocoa
import RxSwift
import RxSwiftUtilities

struct FavoriteViewModel {
    var useCase: FavoriteUseCaseType
    var navigator: FavoriteNavigatorType
}

extension FavoriteViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let deleteTrigger: Driver<IndexPath>
        let selectTrigger: Driver<Int>
    }

    struct Output {
        var isLoading: Driver<Bool>
        var animeList: Driver<[AnimeEntity]>
    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {

        let indicator = ActivityIndicator()

        let animeList = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.fetchEntities()
                    .trackActivity(indicator)
                    .asDriver(onErrorJustReturn: [])
            }

        input.deleteTrigger
            .withLatestFrom(animeList) { indexPath, results in
                return results[indexPath.row]
            }
            .flatMapLatest { anime in
                return self.useCase.deleteEntity(malId: Int(anime.id))
                    .asDriver(onErrorDriveWith: .empty())
            }.drive()
            .disposed(by: disposeBag)

        input.selectTrigger
                    .flatMapLatest { id in
                        return self.useCase.getAnime(input: AnimeDetailRequest(id: id))
                            .trackActivity(indicator)
                            .asDriver(onErrorJustReturn: Constant.Object.defaultAnime)
                    }
                    .drive(onNext: { anime in
                        self.navigator.goDetail(anime: anime)
                    })
                    .disposed(by: disposeBag)

        return Output(
            isLoading: indicator.asDriver(),
            animeList: animeList
        )
    }
}
