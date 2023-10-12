//
//  HomeTableViewCell.swift
//  AnimeHub
//
//  Created by Tobi on 06/10/2023.
//

import UIKit
import SDWebImage
import Reusable

final class HomeTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var animeImageView: UIImageView!
    @IBOutlet private weak var animeLabel: UILabel!

    var addToFavorite: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(anime: Anime) {
        animeLabel.text = anime.title
        animeImageView.sd_setImage(with: URL(string: anime.images.jpg.imageURL), completed: nil)
    }
    
    @IBAction private func favoriteButtonTapped(_ sender: Any) {
        addToFavorite?()
    }
}
