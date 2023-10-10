//
//  AppViewModel.swift
//  AnimeHub
//
//  Created by Tobi on 09/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

extension AppViewModel: ViewModelType {
    struct Input {
        let load: Driver<Void>
    }

    struct Output {

    }

    func transform(_ input: AppViewModel.Input, disposeBag: DisposeBag) -> AppViewModel.Output {

        input.load
            .drive(onNext: { _ in
                self.navigator.toMain()
            })
            .disposed(by: disposeBag)

        return Output()
    }
}
