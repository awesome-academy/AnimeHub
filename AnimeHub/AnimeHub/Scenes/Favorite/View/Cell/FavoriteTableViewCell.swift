//
//  FavoriteTableViewCell.swift
//  AnimeHub
//
//  Created by Tobi on 13/10/2023.
//

import UIKit
import Reusable
import RxSwift

final class FavoriteTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var animeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!

    private let disposeBag = DisposeBag()
    var goDetail: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        makeViewTappable()
    }

    func configCell(anime: AnimeEntity) {
        titleLabel.text = anime.title
        if let url = anime.imageURL {
            animeImageView.sd_setImage(with: URL(string: url), completed: nil)
        }
        scoreLabel.text = "★ \(anime.score)"
        statusLabel.text = anime.status
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
