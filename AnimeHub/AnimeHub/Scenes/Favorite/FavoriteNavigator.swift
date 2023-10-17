//
//  FavoriteNavigator.swift
//  AnimeHub
//
//  Created by Tobi on 13/10/2023.
//

import UIKit

protocol FavoriteNavigatorType {
    func goDetail(anime: Anime)
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let navigationController: UINavigationController

    func goDetail(anime: Anime) {
        let useCase = DetailUseCase()
        let navigator = DetailNavigator(navigationController: navigationController)
        let viewModel = DetailViewModel(useCase: useCase, navigator: navigator)
        let viewController = DetailViewController().then {
            $0.anime = anime
            $0.bindViewModel(to: viewModel)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
