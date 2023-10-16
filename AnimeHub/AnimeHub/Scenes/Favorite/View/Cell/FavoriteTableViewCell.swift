//
//  FavoriteTableViewCell.swift
//  AnimeHub
//
//  Created by Tobi on 13/10/2023.
//

import UIKit
import Reusable

final class FavoriteTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var animeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(anime: AnimeEntity) {
        titleLabel.text = anime.title
        if let url = anime.imageURL {
            animeImageView.sd_setImage(with: URL(string: url), completed: nil)
        }
        scoreLabel.text = "★ \(anime.score)"
        statusLabel.text = anime.status
    }
}
