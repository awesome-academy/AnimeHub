//
//  DetailNavigator.swift
//  AnimeHub
//
//  Created by Tobi on 12/10/2023.
//

import UIKit
import SafariServices

protocol DetailNavigatorType {
    func goToLink(url: URL?)
}

struct DetailNavigator: DetailNavigatorType {
    unowned let navigationController: UINavigationController

    func goToLink(url: URL?) {
        guard let url = url else {
            return
        }

        let safariVC = SFSafariViewController(url: url)
        navigationController.present(safariVC, animated: true)

    }
}
