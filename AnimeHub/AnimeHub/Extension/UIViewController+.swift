//
//  UIViewController+.swift
//  AnimeHub
//
//  Created by Tobi on 09/10/2023.
//

import Foundation
import UIKit

extension UIViewController {

    func showError(message: String, completion: (() -> Void)? = nil) {
        let action = UIAlertController(title: "Error",
                                   message: message,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        action.addAction(okAction)
        present(action, animated: true, completion: nil)
    }
}
