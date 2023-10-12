//
//  String+.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
