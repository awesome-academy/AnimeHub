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
        let navigationController = UINavigationController(rootViewController: viewController)
        let navigator = SearchNavigator(navigationController: navigationController)
        let useCase = SearchUseCase()
        let viewModel = SearchViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }

    static func setUpSeasonalController() -> UINavigationController {
        let viewController = SeasonalViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let navigator = SeasonalNavigator(navigationController: navigationController)
        let useCase = SeasonalUseCase()
        let viewModel = SeasonalViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }

    static func setUpFavoriteController() -> UINavigationController {
        let viewController = FavoriteViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let navigator = FavoriteNavigator(navigationController: navigationController)
        let useCase = FavoriteUseCase()
        let viewModel = FavoriteViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
}
