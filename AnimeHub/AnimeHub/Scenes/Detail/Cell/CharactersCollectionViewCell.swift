//
//  CharactersCollectionViewCell.swift
//  AnimeHub
//
//  Created by Tobi on 16/10/2023.
//

import UIKit
import Reusable
import RxSwift
import SafariServices

final class CharactersCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var charImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var view: UIView!

    private let disposeBag = DisposeBag()
    var goToLink: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        charImageView.applyCircle()
    }

    func configCell(character: Char) {
        charImageView.sd_setImage(with: URL(string: character.images.jpg.imageURL), completed: nil)
        nameLabel.text = character.name

        makeViewTappable(url: URL(string: character.url))
    }

    private func makeViewTappable(url: URL?) {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.goToLink?()
            })
            .disposed(by: disposeBag)
    }
}
