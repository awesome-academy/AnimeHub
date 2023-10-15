//
//  AppNavigator.swift
//  AnimeHub
//
//  Created by Tobi on 09/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol AppNavigatorType {
    func toMain()
}

enum AppTabBar: CaseIterable {
    case home
    case search
    case seasonal
    case favorite

    func getLabel() -> String {
        switch self {
        case .home:
            return StringGen.homeTabTitle
        case .search:
            return StringGen.searchTabTitle
        case .seasonal:
            return StringGen.seasonalTabTitle
        case .favorite:
            return StringGen.favoriteTabTitle
        }
    }

    func getIcon() -> UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: StringGen.homeIcon)
        case .search:
            return UIImage(systemName: StringGen.searchIcon)
        case .seasonal:
            return UIImage(systemName: StringGen.seasonalIcon)
        case .favorite:
            return UIImage(systemName: StringGen.favoriteIcon)
        }
    }
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow

    func toMain() {
        let tabBar = UITabBarController()

        configureTabBar(tabBar: tabBar)
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }

    func configureTabBar(tabBar: UITabBarController) {

        let homeVC = UINavigationController.setUpHomeController()
        let searchVC = UINavigationController.setUpSearchController()
        let seasonalVC = UINavigationController.setUpSeasonalController()
        let favoritesVC = UINavigationController.setUpFavoriteController()

        tabBar.setViewControllers([homeVC, searchVC, seasonalVC, favoritesVC], animated: true)
        tabBar.tabBar.do {
            $0.backgroundColor = .black
            $0.tintColor = .white
        }

        guard let items = tabBar.tabBar.items else {
            return
        }

        for index in 0..<items.count {
            items[index].title = AppTabBar.allCases[index].getLabel()
            items[index].image = AppTabBar.allCases[index].getIcon()
        }

    }
}
