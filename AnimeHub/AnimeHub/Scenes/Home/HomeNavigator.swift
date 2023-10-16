//
//  HomeNavigator.swift
//  AnimeHub
//
//  Created by Tobi on 07/10/2023.
//

import UIKit

protocol HomeNavigatorType {
    func openBottomSheet(anime: Anime)
}

struct HomeNavigator: HomeNavigatorType {
    unowned let navigationController: UINavigationController

    func openBottomSheet(anime: Anime) {
        let controller = HomeViewController()
        let useCase = HomeUseCase()
        let viewModel = BottomSheetViewModel(useCase: useCase, anime: anime)
        let bottomSheet = BottomSheetViewController().then {
            $0.modalPresentationStyle = .custom
            $0.selectionAnime = anime
            $0.transitioningDelegate = controller
            $0.bindViewModel(to: viewModel)
        }
        navigationController.present(bottomSheet, animated: true, completion: nil)
    }
}
