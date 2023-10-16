//
//  DetailViewController.swift
//  AnimeHub
//
//  Created by Tobi on 12/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController, Bindable {

    @IBOutlet private weak var animeImageView: UIImageView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var membersLabel: UILabel!
    @IBOutlet private weak var favoritesLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var episodesLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var seasonLabel: UILabel!
    @IBOutlet private weak var studioLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var charactersCollection: UICollectionView!
    @IBOutlet private weak var watchingProgress: UIProgressView!
    @IBOutlet private weak var completedProgress: UIProgressView!
    @IBOutlet private weak var onHoldProgress: UIProgressView!
    @IBOutlet private weak var droppedProgress: UIProgressView!
    @IBOutlet private weak var planProgress: UIProgressView!
    @IBOutlet private weak var watchingLabel: UILabel!
    @IBOutlet private weak var completedLabel: UILabel!
    @IBOutlet private weak var onHoldLabel: UILabel!
    @IBOutlet private weak var droppedLabel: UILabel!
    @IBOutlet private weak var planLabel: UILabel!
    @IBOutlet private weak var totalMembers: UILabel!
    @IBOutlet private weak var genres: UILabel!

    var viewModel: DetailViewModel!
    var anime: Anime?
    private let disposeBag = DisposeBag()
    private var selectTrigger = PublishSubject<IndexPath>()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let anime = anime {
            configView(anime)
        }
        charactersCollection.delegate = self
    }

    func bindViewModel() {
        let input = DetailViewModel.Input(
            id: Driver.just(anime?.malId ?? 0),
            load: Driver.just(()),
            selectTrigger: selectTrigger.asDriver(onErrorJustReturn: IndexPath())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.characters
            .drive(charactersCollection.rx.items) { collection, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: CharactersCollectionViewCell = collection.dequeueReusableCell(for: indexPath)
                cell.configCell(character: element.character)
                cell.goToLink = {
                    self.selectTrigger.onNext(IndexPath(row: row, section: 0))
                }
                return cell
            }
            .disposed(by: disposeBag)

        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: disposeBag)

        output.statistics
            .drive(
                onNext: { [unowned self] result in
                    let statistics = result.data
                    let total = statistics.total
                    self.totalMembers.text = String(describing: statistics.total)
                    configProgress(
                        progressView: watchingProgress,
                        label: watchingLabel,
                        value: statistics.watching,
                        total: total
                    )
                    configProgress(
                        progressView: completedProgress,
                        label: completedLabel,
                        value: statistics.completed,
                        total: total
                    )
                    configProgress(
                        progressView: onHoldProgress,
                        label: onHoldLabel,
                        value: statistics.onHold,
                        total: total
                    )
                    configProgress(
                        progressView: droppedProgress,
                        label: droppedLabel,
                        value: statistics.dropped,
                        total: total
                    )
                    configProgress(
                        progressView: planProgress,
                        label: planLabel,
                        value: statistics.planToWatch,
                        total: total
                    )
                }
            )
            .disposed(by: disposeBag)
    }

    func configProgress(progressView: UIProgressView, label: UILabel, value: Int, total: Int) {
        progressView.progress = Float(value) / Float(total)
        label.text = String(describing: value)
    }

    private func configView(_ anime: Anime) {
        self.charactersCollection.do {
            $0.register(cellType: CharactersCollectionViewCell.self)
        }

        let genres = anime.genres.map { item in
            return item.name
        }

        let combinedGenres = genres.reduce("") { (result, string) in
            if result.isEmpty {
                return string
            } else {
                return result + ", " + string
            }
        }

        self.do {
            $0.navigationItem.title = StringGen.detailTitle
            $0.animeImageView.sd_setImage(with: URL(string: anime.images.jpg.imageURL), completed: nil)
            $0.titleLabel.text = anime.title
            $0.genres.text = combinedGenres
            $0.typeLabel.text = anime.type
            $0.statusLabel.text = anime.status
            $0.descriptionLabel.text = anime.synopsis
            $0.sourceLabel.text = anime.source
            $0.ratingLabel.text = anime.rating
            $0.studioLabel.text = anime.studios.first?.name

            if let score = anime.score {
                $0.scoreLabel.text = "★ \(score)"
            }
            if let rank = anime.rank {
                $0.rankLabel.text = "#\(rank)"
            }
            if let popular = anime.popularity {
                $0.popularityLabel.text = "#\(popular)"
            }
            if let members = anime.members {
                $0.membersLabel.text = String(describing: members)
            }
            if let favorites = anime.favorites {
                $0.favoritesLabel.text = String(describing: favorites)
            }
            if let episodes = anime.episodes {
                $0.episodesLabel.text = String(describing: episodes) + " eps"
            }
            if let season = anime.season, let year = anime.year {
                $0.seasonLabel.text = "\(season) \(year)".capitalizeFirstLetter()
            }
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.Size.charCellW, height: Constant.Size.charCellH)
    }
}
