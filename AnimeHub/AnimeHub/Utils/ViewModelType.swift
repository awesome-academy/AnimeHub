//
//  ViewModelType.swift
//  AnimeHub
//
//  Created by Tobi on 07/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output
}
