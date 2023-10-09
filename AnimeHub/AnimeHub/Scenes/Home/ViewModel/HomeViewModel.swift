//
//  HomeViewModel.swift
//  AnimeHub
//
//  Created by Tobi on 06/10/2023.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import RxSwiftUtilities

struct HomeViewModel {
    let useCase: HomeUseCaseType
    let navigator: HomeNavigatorType
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let load: Driver<Void>
    }

    struct Output {
        var animeList: Driver<[Anime]>
        var isLoading: Driver<Bool>
    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let indicator = ActivityIndicator()

        let anime = input.load
            .flatMapLatest { _ in
                return self.useCase.getRecommendations()
                    .trackActivity(indicator)
                    .asDriver(onErrorJustReturn: [])
            }
        return Output(animeList: anime, isLoading: indicator.asDriver())
    }
}
