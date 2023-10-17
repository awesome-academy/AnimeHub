//
//  CharacterResponse.swift
//  AnimeHub
//
//  Created by Tobi on 16/10/2023.
//

import Foundation

struct ListCharactersResponse: Codable {
    var data: [CharacterResponse]
}

struct CharacterResponse: Codable {
    var character: Char
}
