//
//  UINavigationController+.swift
//  AnimeHub
//
//  Created by Tobi on 09/10/2023.
//

import UIKit

extension UINavigationController {
    static func setUpHomeController() -> UINavigationController {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let navigator = HomeNavigator(navigationController: navigationController)
        let useCase = HomeUseCase()
        let viewModel = HomeViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }

    static func setUpSearchController() -> UINavigationController {
        let viewController = SearchViewController()
        let navigator = SearchNavigator()
        let useCase = SearchUseCase()
        let viewModel = SearchViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        return UINavigationController(rootViewController: viewController)
    }

    static func setUpSeasonalController() -> UINavigationController {
        let viewController = SeasonalViewController()
        let navigator = SeasonalNavigator()
        let useCase = SeasonalUseCase()
        let viewModel = SeasonalViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
}