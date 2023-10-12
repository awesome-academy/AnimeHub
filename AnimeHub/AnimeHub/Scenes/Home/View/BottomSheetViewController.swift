//
//  BottomSheetViewController.swift
//  AnimeHub
//
//  Created by Tobi on 11/10/2023.
//

import UIKit
import GMStepper
import RxSwift
import RxCocoa

final class BottomSheetViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var watchingButton: UIButton!
    @IBOutlet private weak var completeButton: UIButton!
    @IBOutlet private weak var onHoldButton: UIButton!
    @IBOutlet private weak var droppedButton: UIButton!
    @IBOutlet private weak var planButton: UIButton!

    var selectionAnime: Anime?
    var buttons = [UIButton]()
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let anime = selectionAnime {
            configView(anime: anime)
        }
        handleButtonsTapped()
    }

    private func configView(anime: Anime) {
        self.titleLabel.text = anime.title
        buttons = [watchingButton, completeButton, onHoldButton, droppedButton, planButton]
        setSelectedButton(watchingButton)
        for button in buttons {
            button.applyBorderOutline()
        }
    }

    private func setSelectedButton(_ selectedButton: UIButton) {
        for button in buttons {
            button == selectedButton ? button.setSelected() : button.setDeselected()
        }
    }

    private func handleButtonsTapped() {
        for button in buttons {
            button.rx.tap.subscribe(onNext: {
                self.setSelectedButton(button)
            })
            .disposed(by: disposeBag)
        }
    }

    @IBAction private func changeScore(_ sender: GMStepper) {
        // TODO: Do later
    }
}
