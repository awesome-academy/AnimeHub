//
//  SeasonalNavigator.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import UIKit

protocol SeasonalNavigatorType {
    func goDetail(anime: Anime)
}

struct SeasonalNavigator: SeasonalNavigatorType {
    unowned let navigationController: UINavigationController

    func goDetail(anime: Anime) {
        let useCase = DetailUseCase()
        let navigator = DetailNavigator()
        let viewModel = DetailViewModel(useCase: useCase, navigator: navigator)
        let viewController = DetailViewController().then {
            $0.anime = anime
            $0.bindViewModel(to: viewModel)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
