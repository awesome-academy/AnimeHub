//
//  TabBarViewController.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    private let homeViewController = UINavigationController(rootViewController: HomeViewController())
    private let searchViewController = UINavigationController(rootViewController: SearchViewController())
    private let seasonalViewController = UINavigationController(rootViewController: SeasonalViewController())
    private let favoriteViewController = UINavigationController(rootViewController: FavoriteViewController())

    override func viewDidLoad() {
        super.viewDidLoad()

        configTabBar()
    }

    private func configTabBar() {
        self.setViewControllers(
            [homeViewController, searchViewController, seasonalViewController, favoriteViewController],
            animated: true)
        self.tabBar.backgroundColor = .black
        self.tabBar.tintColor = .white

        homeViewController.title = StringGen.homeTabTitle
        searchViewController.title = StringGen.searchTabTitle
        seasonalViewController.title = StringGen.seasonalTabTitle
        favoriteViewController.title = StringGen.favoriteTabTitle

        guard let items = self.tabBar.items else {
            return
        }

        let images = [StringGen.homeIcon, StringGen.searchIcon, StringGen.seasonalIcon, StringGen.favoriteIcon]

        for index in 0..<items.count {
            items[index].image = UIImage(systemName: images[index])
        }
    }
}
