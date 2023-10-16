//
//  UIView+.swift
//  AnimeHub
//
//  Created by Tobi on 16/10/2023.
//

import UIKit

extension UIView {
    func applyCircle() {
        layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
