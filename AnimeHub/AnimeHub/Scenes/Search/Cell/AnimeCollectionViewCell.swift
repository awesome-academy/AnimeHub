//
//  AnimeCollectionViewCell.swift
//  AnimeHub
//
//  Created by Tobi on 10/10/2023.
//

import UIKit
import Reusable

final class AnimeCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configView()
    }

    private func configView() {
        imageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        }
    }

    func configCell(anime: Anime) {
        titleLabel.text = anime.title
        imageView.sd_setImage(with: URL(string: anime.images.jpg.imageURL), completed: nil)
    }
}
