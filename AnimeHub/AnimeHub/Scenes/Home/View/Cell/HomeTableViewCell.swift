//
//  HomeTableViewCell.swift
//  AnimeHub
//
//  Created by Tobi on 06/10/2023.
//

import UIKit
import SDWebImage
import Reusable
import RxSwift

final class HomeTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var animeImageView: UIImageView!
    @IBOutlet private weak var animeLabel: UILabel!
    @IBOutlet private weak var view: UIView!

    var addToFavorite: (() -> Void)?
    var goDetail: (() -> Void)?
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()

        makeViewTappable()
    }

    func configCell(anime: Anime) {
        animeLabel.text = anime.title
        animeImageView.sd_setImage(with: URL(string: anime.images.jpg.imageURL), completed: nil)
    }
    
    @IBAction private func favoriteButtonTapped(_ sender: Any) {
        addToFavorite?()
    }

    private func makeViewTappable() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.goDetail?()
            })
            .disposed(by: disposeBag)
    }
}
