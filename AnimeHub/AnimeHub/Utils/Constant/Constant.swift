//
//  Constant.swift
//  AnimeHub
//
//  Created by Tobi on 09/10/2023.
//

import UIKit

struct Constant {
    struct Size {
        static var rowHeight = CGFloat(120)
        static var animeCellHeight = CGFloat(250)
        static var paddingHorizontal = CGFloat(16)
        static var favoriteCellHeight = CGFloat(180)
        static var charCellW = CGFloat(120)
        static var charCellH = CGFloat(160)
    }

    struct Number {
        static var cellInRow = CGFloat(2)
        static var defaultScore = 8.0
    }

    struct String {
        static var empty = ""
        static var defaultStatus = "Watching"
        static var isSaved = "Already in your list"
    }

    struct Object {
        static var defaultStatistics = Statistics(
            watching: 0,
            completed: 0,
            onHold: 0,
            dropped: 0,
            planToWatch: 0,
            total: 0)
        static var defaultFilter = Filter.tv
    }
}
