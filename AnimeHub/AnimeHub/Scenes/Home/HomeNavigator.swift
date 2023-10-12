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
        let bottomSheet = BottomSheetViewController().then {
            $0.modalPresentationStyle = .custom
            $0.selectionAnime = anime
            $0.transitioningDelegate = controller
        }
        navigationController.present(bottomSheet, animated: true, completion: nil)
    }
}
