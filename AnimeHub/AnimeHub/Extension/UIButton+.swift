//
//  UIButton+.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import UIKit
import Then

extension UIButton {
    func applyBorderOutline() {
        self.titleEdgeInsets.left = 8
        self.titleEdgeInsets.right = 8
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.layer.do {
            $0.borderWidth = 2
            $0.borderColor = UIColor.white.cgColor
        }
    }

    func setSelected() {
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
    }

    func setDeselected() {
        self.backgroundColor = .clear
        self.setTitleColor(.white, for: .normal)
    }
}
