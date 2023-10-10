//
//  Bindable.swift
//  AnimeHub
//
//  Created by Tobi on 07/10/2023.
//

import UIKit
import RxSwift

public protocol Bindable: AnyObject {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }

    func bindViewModel()
}

extension Bindable where Self: UIViewController {
    public func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()

        bindViewModel()
    }
}
