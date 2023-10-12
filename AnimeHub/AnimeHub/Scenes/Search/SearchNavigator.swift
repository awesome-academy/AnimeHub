//
//  SearchNavigator.swift
//  AnimeHub
//
//  Created by Tobi on 10/10/2023.
//

import UIKit

protocol SearchNavigatorType {
    func goDetail(anime: Anime)
}

struct SearchNavigator: SearchNavigatorType {
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
