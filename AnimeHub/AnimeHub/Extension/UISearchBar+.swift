//
//  UISearchhBar+.swift
//  AnimeHub
//
//  Created by Tobi on 10/10/2023.
//

import UIKit
import Then

extension UISearchBar {
    func customizeView() {
        self.barTintColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.backgroundImage = UIImage()
        self.searchTextField.then {
            $0.backgroundColor = .white
            $0.textColor = .black
            $0.leftView?.tintColor = .black
            $0.layer.cornerRadius = 32
            $0.layer.masksToBounds = true
        }
        self.updateHeight(height: 60)
    }

    func updateHeight(height: CGFloat, radius: CGFloat = 8.0) {
        let image: UIImage? = UIImage.imageWithColor(color: UIColor.clear, size: CGSize(width: 1, height: height))
        setSearchFieldBackgroundImage(image, for: .normal)
        for subview in self.subviews {
            for subSubViews in subview.subviews {
                if #available(iOS 13.0, *) {
                    for child in subSubViews.subviews {
                        if let textField = child as? UISearchTextField {
                            textField.then {
                                $0.layer.cornerRadius = radius
                                $0.clipsToBounds = true
                            }
                        }
                    }
                    continue
                }
                if let textField = subSubViews as? UITextField {
                    textField.then {
                        $0.layer.cornerRadius = radius
                        $0.clipsToBounds = true
                    }
                }
            }
        }
    }
}
