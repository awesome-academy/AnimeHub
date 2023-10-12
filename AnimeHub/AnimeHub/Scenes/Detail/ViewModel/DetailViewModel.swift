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
        let load: Driver<Void>
    }

    struct Output {
        var isLoading: Driver<Bool>
    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let indicator = ActivityIndicator()

        return Output(isLoading: indicator.asDriver())
    }
}
