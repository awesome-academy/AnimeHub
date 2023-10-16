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

final class BottomSheetViewController: UIViewController, Bindable {

    var viewModel: BottomSheetViewModel!
    private let disposeBag = DisposeBag()

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var watchingButton: UIButton!
    @IBOutlet private weak var completeButton: UIButton!
    @IBOutlet private weak var onHoldButton: UIButton!
    @IBOutlet private weak var droppedButton: UIButton!
    @IBOutlet private weak var planButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!

    var selectionAnime: Anime?
    var statusButton = [UIButton]()
    var scoreValue = Constant.Number.defaultScore
    var statusValue = Constant.String.defaultStatus
    private var score = PublishSubject<Double>()
    private var status = PublishSubject<String>()
    private var addTrigger = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let anime = selectionAnime {
            configView(anime: anime)
        }
        handleButtonsTapped()
    }

    func bindViewModel() {
        let loadTrigger = Driver.just(())

        let input = BottomSheetViewModel.Input(
            load: loadTrigger,
            addTrigger: addTrigger.asDriver(onErrorJustReturn: ()),
            score: score.asDriver(onErrorDriveWith: .empty()),
            status: status.asDriver(onErrorJustReturn: Constant.String.empty)
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: disposeBag)

        output.isSaved.drive(
            onNext: { [unowned self] isSaved in
                if isSaved { 
                    disableButton()
                } else {
                    self.addButton.rx.tap.asDriver().drive(
                        onNext: {
                            addAnime()
                        }
                    )
                    .disposed(by: self.disposeBag)
                }
            }
        )
        .disposed(by: disposeBag)
    }

    private func disableButton() {
        self.addButton.do {
            $0.setTitle(Constant.String.isSaved, for: .normal)
            $0.backgroundColor = .clear
        }
    }

    private func addAnime() {
        self.score.onNext(scoreValue)
        self.status.onNext(statusValue)
        self.addTrigger.onNext(())
        self.dismiss(animated: true, completion: nil)
    }

    private func configView(anime: Anime) {
        self.titleLabel.text = anime.title
        statusButton = [watchingButton, completeButton, onHoldButton, droppedButton, planButton]
        setSelectedButton(watchingButton)
        for button in statusButton {
            button.applyBorderOutline()
        }
    }

    private func setSelectedButton(_ selectedButton: UIButton) {
        statusValue = selectedButton.currentTitle ?? Constant.String.empty
        for button in statusButton {
            button == selectedButton ? button.setSelected() : button.setDeselected()
        }
    }

    private func handleButtonsTapped() {
        for button in statusButton {
            button.rx.tap.subscribe(onNext: {
                self.setSelectedButton(button)
            })
            .disposed(by: disposeBag)
        }
    }

    @IBAction private func changeScore(_ sender: GMStepper) {
        scoreValue = sender.value
    }
}
