//
//  SeasonalViewController.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class SeasonalViewController: UIViewController, Bindable {

    @IBOutlet private weak var categoryButton: UIButton!
    @IBOutlet private weak var animeCollectionView: UICollectionView!

    var viewModel: SeasonalViewModel!
    private var selectionFilter = "tv" // TODO: test category
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        animeCollectionView.delegate = self
    }

    private func configView() {
        self.navigationItem.title = StringGen.seasonalTitle
        self.animeCollectionView.register(cellType: AnimeCollectionViewCell.self)
        setupMenuButton()
    }

    private func changeFilter(filter: Filter) {
        self.categoryButton.setTitle("\(filter.rawValue.capitalizeFirstLetter()) ▾", for: .normal)
        selectionFilter = filter.rawValue
    }

    private func setupMenuButton() {
        let filterMenu = Filter.allCases.map { item in
            return UIAction(title: item.rawValue.capitalized) { [weak self] _ in
                    self?.changeFilter(filter: item)
                }
        }

        categoryButton.do {
            $0.menu = UIMenu(children: filterMenu)
            $0.showsMenuAsPrimaryAction = true
        }
    }

    func bindViewModel() {
        let loadTrigger = Driver.just(())

        let input = SeasonalViewModel.Input(
            load: loadTrigger,
            filter: Driver.just(selectionFilter)
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.animeList
            .drive(animeCollectionView.rx.items) { table, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: AnimeCollectionViewCell = table.dequeueReusableCell(for: indexPath)
                cell.configCell(anime: element)
                return cell
            }
            .disposed(by: disposeBag)

        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
    }
}

extension SeasonalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (animeCollectionView.frame.width - Constant.Size.paddingHorizontal * 2) / Constant.Number.cellInRow
        let height = Constant.Size.animeCellHeight

        return CGSize(width: width, height: height)
    }
}
