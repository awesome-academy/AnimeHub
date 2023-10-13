//
//  AnimeCollectionViewCell.swift
//  AnimeHub
//
//  Created by Tobi on 10/10/2023.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

final class AnimeCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var view: UIView!

    var goDetail: (() -> Void)?
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()

        configView()
        makeViewTappable()
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
