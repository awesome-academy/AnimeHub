//
//  DatabaseError.swift
//  AnimeHub
//
//  Created by Tobi on 16/10/2023.
//

import Foundation

enum DatabaseError: Error {
    case checkExistFailed
    case saveDataFailed
    case fetchDataFailed
    case deleteDataFailed
}
